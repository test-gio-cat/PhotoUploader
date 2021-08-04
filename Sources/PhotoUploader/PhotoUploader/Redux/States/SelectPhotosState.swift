//
//  SelectPhotosState.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 31/07/21.
//

import UIKit

struct SelectPhotosState: Equatable {
    var title: String = "Step 2: Photo Selection"
    var photoLibraryTitle: String = "Upload from Library"
    var cameraTitle: String = "Take photo"
    var photos: [Data]
    var isLoading: Bool
    var nextStepTitle: String
    var isUploading: Bool
    var uploadTitle: String
    var uploadError: String?
    var progress: Progress
    var selectPhotoError: String?
}

struct Progress: Equatable {
    let percentage: Double
    let completed: Int
    let links: [String]
    
    static var empty: Progress {
        .init(percentage: 0, completed: 0, links: [])
    }
    
    var isCompleted: Bool {
        percentage == 1 && links.count == completed
    }
}
