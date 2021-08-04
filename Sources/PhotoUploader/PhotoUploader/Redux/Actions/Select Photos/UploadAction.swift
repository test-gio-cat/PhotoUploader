//
//  UploadAction.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 02/08/21.
//

import ReSwift
import ReSwiftThunk
import Foundation
import Combine

func uploadPhotosThunk(service: ImagesUploadServiceProtocol = ImagesUploadService(),
                       _ photos: [Data]) -> Thunk<AppState> {
    Thunk<AppState> { dispatch, getState in
        service
            .upload(images: photos)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    dispatch(UploadActionFailure(error: error.localizedDescription))
                }
            }, receiveValue: { progress in
                if progress.isCompleted {
                    dispatch(GoToLinkList(list: progress.links))
                } else {
                    dispatch(UploadInProgress(progress: progress))
                }
            })
            .store(in: &cancellables)
        dispatch(UploadInProgress(progress: .init(percentage: 0, completed: 0, links: [])))
    }
}
