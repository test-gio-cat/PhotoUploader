//
//  UploadViewController.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 01/08/21.
//

import UIKit
import ReSwift

class LinkListViewController: UIViewController {
    @IBOutlet private weak var header: PhotoUploaderHeaderView!
    @IBOutlet private weak var restartButton: PhotoUploaderButton!
    @IBOutlet private weak var tableView: LinkListTableView!
    
    private var tableDataSource: TableDataSource<LinkListTableViewCell, String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        tableView.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {
            $0.select {
                $0.linkListState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
}

extension LinkListViewController: StoreSubscriber {
    func newState(state: LinkListState) {
        header.title.text = state.title
        header.back.isHidden = true
        restartButton.setTitle(state.finishTitle, for: .normal)
        listFetched(state.links)
    }
    
    private func listFetched(_ links: [String]) {
        tableDataSource = TableDataSource(cellIdentifier: LinkListTableViewCell.identifier,
                                          models: links) { cell, model in
            cell.urlLabel.text = model
            return cell
        }
        tableView.delegate = self
        tableView.dataSource = tableDataSource
        tableView.reloadData()
    }
}

extension LinkListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        UIPasteboard.general.string = store.state.linkListState.links[indexPath.row]
        showToast(message: "URL Copied", font: .medium(ofSize: 18))
    }
}

extension LinkListViewController {
    @IBAction func onFinish(_ sender: UIButton) {
        store.dispatch(BackToStart())
    }
}
