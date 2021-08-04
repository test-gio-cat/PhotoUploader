//
//  SelectPhotosViewController.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit
import ReSwift

class SelectPhotosViewController: UIViewController {
    @IBOutlet private weak var header: PhotoUploaderHeaderView!
    @IBOutlet private weak var continueButton: PhotoUploaderButton!
    @IBOutlet private weak var content: SelectPhotosContent!
    @IBOutlet private weak var loadingView: PhotoUploaderLoadingView!
    
    private var collectionDataSource: CollectionDataSource<PhotoCollectionViewCell, Data>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {
            $0.select {
                $0.selectPhotosState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        content.photosCollection.collectionViewLayout.invalidateLayout()
    }
}

extension SelectPhotosViewController {
    @IBAction func onBack(_ sender: UIButton) {
        store.dispatch(PopAction())
    }
    
    @IBAction func onSelectFromLibrary(_ sender: UIButton) {
        if #available(iOS 14, *) {
            store.dispatch(GoToLibraryPicker(picker: ImagePicker()))
        } else {
            store.dispatch(GoToLibraryPicker(picker: LegacyImagePicker()))
        }
    }
    
    @IBAction func onContinue(_ sender: UIButton) {
        store.dispatch(uploadPhotosThunk(store.state.selectPhotosState.photos))
    }
    
    @IBAction func onTakePhoto(_ sender: UIButton) {
        store.dispatch(TakePhoto(picker: LegacyImagePicker()))
    }
}

extension SelectPhotosViewController: StoreSubscriber {
    func newState(state: SelectPhotosState) {
        header.title.text = state.title
        
        continueButton.setTitle(state.nextStepTitle, for: .normal)
        continueButton.isEnabled = state.photos.count > 0
        
        imagesFetched(state.photos)
        content.cameraButton.setTitle(state.cameraTitle, for: .normal)
        content.photoLibraryButton.setTitle(state.photoLibraryTitle, for: .normal)
        showActivityIndicator(state.isLoading)
        content.photoLibraryButton.isEnabled = !state.isLoading
        content.cameraButton.isEnabled = !state.isLoading
        
        loadingView.isHidden = !state.isUploading
        loadingView.progressView.setProgress(Float(state.progress.percentage),
                                             animated: true)
        
        loadingView.titleLabel.text = state.uploadTitle
        
        onError(state.uploadError,
                actions: [.init(title: "Retry",
                                action: { store.dispatch(uploadPhotosThunk(state.photos)) }),
                          .init(title: "See \(state.progress.links.count) links", action: { store.dispatch(GoToLinkList(list: state.progress.links)) }),
                          .init(title: "Cancel",
                                action: { })],
                state: state,
                filtered: { $0.progress.links.count > 0 && $1.title == "Retry" })
        
        onError(state.selectPhotoError,
                actions: [.init(title: "Retry",
                                action: {
                                 if #available(iOS 14, *) { store.dispatch(GoToLibraryPicker(picker: ImagePicker())) }
                                 else { store.dispatch(GoToLibraryPicker(picker: LegacyImagePicker())) }
                                }),
                          .init(title: "Cancel",
                                action: { })],
                state: state,
                filtered: { _, _ in true })
    }
    
    private func imagesFetched(_ images: [Data]) {
        collectionDataSource = CollectionDataSource(cellIdentifier: PhotoCollectionViewCell.identifier,
                                                    models: images,
                                                    configureCell: { cell, model in
                                                        cell.imageView.image = UIImage(data: model)
                                                        cell.onDelete = { store.dispatch(DeletePhotoAction(photo: model)) }
                                                        return cell
                                                    })
        
        content.photosCollection.dataSource = collectionDataSource
        content.photosCollection.delegate = self
        content.photosCollection.reloadData()
    }
    
    private func onError(_ error: String?,
                         actions: [AlertAction],
                         state: SelectPhotosState,
                         filtered: @escaping (SelectPhotosState, AlertAction) -> Bool) {
        guard let message = error else { return }
        UIAlertController
            .showError(message: message,
                       actions: actions.filter({ filtered(state, $0) }),
                       in: self)
    }
    
    private func showActivityIndicator(_ isLoading: Bool) {
        content.activityIndicator.isHidden = !isLoading
        isLoading ? content.activityIndicator.startAnimating() : content.activityIndicator.stopAnimating()
    }
}

extension SelectPhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: content.photosCollection.bounds.width / columns(for: content.photosCollection.bounds.width),
              height: content.photosCollection.bounds.width / columns(for: content.photosCollection.bounds.width))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    private func columns(for width: CGFloat) -> CGFloat {
        ceil(2 * width / 375)
    }
}
