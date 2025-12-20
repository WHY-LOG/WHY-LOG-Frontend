//
//  ProfileModel.swift
//  WHYLOG
//
//  Created by 김종수 on 12/18/25.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

class ProfileModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published private(set) var imageState: ImageState = .empty
    @Published var imageSelection: PhotosPickerItem?{
        didSet{
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(Progress())
            }else {
                imageState = .empty
                
            }
        }
    }
    
    private var imageSelectionData: Data? = nil
    
    enum ImageState{
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    
    
    
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Data.self){ result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else { return }
                switch result {
                case .success(let data?):
                    if let uiImage = UIImage(data: data) {
                        self.imageSelectionData = data
                        self.imageState = .success(Image(uiImage: uiImage))
                    } else {
                        self.imageState = .empty
                    }
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    // 프로필 디폴트 값 (삭제 시 적용됨)
    func deleteProfile() {
        name = ""
        email = ""
        imageSelection = nil
        imageState = .empty
    }
}
