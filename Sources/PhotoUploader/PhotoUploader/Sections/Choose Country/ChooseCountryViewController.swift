//
//  ViewController.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import UIKit
import ReSwift

class ChooseCountryViewController: UIViewController {
    @IBOutlet private weak var tableView: ChooseCountryTableView!
    @IBOutlet private weak var progressView: ProgressView!
    @IBOutlet private weak var header: PhotoUploaderHeaderView!
    @IBOutlet private weak var continueButton: PhotoUploaderButton!
    
    private var tableDataSource: IndexedTableDataSource<ChooseCountryTableViewCell, String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        tableView.setup()
        store.dispatch(fetchCountriesThunk())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {
            $0.select {
                $0.chooseCountryState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
}

extension ChooseCountryViewController: StoreSubscriber {
    func newState(state: ChooseCountryState) {
        tableView.isHidden = state.countries.isEmpty
        listFetched(state.countries, selectedCountry: state.selectedCountry)
        progressView.isHidden = !state.showLoading
        onError(state.error)
        header.title.text = state.title
        header.back.isHidden = true
        continueButton.isEnabled = state.selectedCountry != nil
        continueButton.setTitle(state.nextStepTitle, for: .normal)
    }
    
    private func listFetched(_ countries: [(String, [String])], selectedCountry: String?) {
        tableDataSource = IndexedTableDataSource(cellIdentifier: ChooseCountryTableViewCell.identifier,
                                                 models: countries) { cell, model in
            cell.nameLabel.text = model
            cell.select(if: model == selectedCountry)
            return cell
        }
        
        tableView.dataSource = tableDataSource
        tableView.delegate = self
        tableView.reloadData()
    }
    
    private func onError(_ error: String?) {
        guard let message = error else { return }
        UIAlertController
            .showError(message: message,
                       actions: [.init(title: "Retry",
                                       action: { store.dispatch(fetchCountriesThunk()) })],
                       in: self)
    }
}

extension ChooseCountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        store
            .dispatch(SelectCountryAction(country: store
                                            .state
                                            .chooseCountryState
                                            .countries[indexPath.section].1[indexPath.row]))
    }
}

extension ChooseCountryViewController {
    @IBAction func onContinue(_ sender: UIButton) {
        store.dispatch(GoToSelectPhotos())
    }
}
