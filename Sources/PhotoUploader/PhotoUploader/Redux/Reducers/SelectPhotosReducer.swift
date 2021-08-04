//
//  SelectPhotosReducer.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//
import ReSwift

func selectPhotosReducer(action: Action, state: SelectPhotosState?) -> SelectPhotosState {
    var state = state ?? SelectPhotosState(photos: [],
                                           isLoading: false,
                                           nextStepTitle: nextStepTitle(for: 0),
                                           isUploading: false,
                                           uploadTitle: "Upload in progress...",
                                           progress: .empty)
    switch action {
    case let selectPhotos as SelectPhotosAction:
        let photos = state.photos + selectPhotos.photos
        state = SelectPhotosState(photos: photos,
                                  isLoading: false,
                                  nextStepTitle: nextStepTitle(for: photos.count),
                                  isUploading: false,
                                  uploadTitle: "Upload in progress...",
                                  progress: .empty)
    case _ as LoadingPhotosAction:
        state = SelectPhotosState(photos: state.photos,
                                  isLoading: true,
                                  nextStepTitle: state.nextStepTitle,
                                  isUploading: false,
                                  uploadTitle: "Upload in progress...",
                                  progress: .empty)
    case let deletePhoto as DeletePhotoAction:
        let newPhotos = state.photos.filter({ $0 != deletePhoto.photo })
        
        state = SelectPhotosState(photos: newPhotos,
                                  isLoading: false,
                                  nextStepTitle: nextStepTitle(for: newPhotos.count),
                                  isUploading: false,
                                  uploadTitle: "Upload in progress...",
                                  progress: .empty)
    case let uploadInProgress as UploadInProgress:
        state = SelectPhotosState(photos: state.photos,
                                  isLoading: state.isLoading,
                                  nextStepTitle: state.nextStepTitle,
                                  isUploading: true,
                                  uploadTitle: uploadTitle(completed: uploadInProgress.progress.completed, total: state.photos.count),
                                  progress: uploadInProgress.progress)
    case let uploadFailure as UploadActionFailure:
        state = SelectPhotosState(photos: state.photos,
                                  isLoading: state.isLoading,
                                  nextStepTitle: state.nextStepTitle,
                                  isUploading: false,
                                  uploadTitle: "Upload in progress...",
                                  uploadError: uploadFailure.error,
                                  progress: state.progress)
    case _ as BackToStart:
        state = SelectPhotosState(photos: [],
                                  isLoading: false,
                                  nextStepTitle: nextStepTitle(for: 0),
                                  isUploading: false,
                                  uploadTitle: "Upload in progress...",
                                  progress: .empty)
    case let selectPhotoFailure as SelectPhotoFailure:
        state = SelectPhotosState(photos: state.photos,
                                  isLoading: false,
                                  nextStepTitle: state.nextStepTitle,
                                  isUploading: false,
                                  uploadTitle: state.uploadTitle,
                                  progress: .empty,
                                  selectPhotoError: selectPhotoFailure.error)
    default:
        break
    }
    return state
}

private func nextStepTitle(for count: Int) -> String {
    let messagesMap = [0: "Upload",
                       1: "Upload 1 photo"]
    return messagesMap[count, default: "Upload \(count) photos"]
}

private func uploadTitle(completed: Int, total: Int) -> String {
    completed == total ? "Generating URLs..." : "\(completed) files uploaded..."
}
