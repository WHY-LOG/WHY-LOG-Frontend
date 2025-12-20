//
//  InitializeProfileViewModel.swift
//  WHYLOG
//
//  Created by 김종수 on 12/17/25.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    // UI State
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var isSaveSuccess: Bool = false
    @Published private(set) var imageState: ProfileModel.ImageState = .empty
    
    // Dependencies
    private let service = ProfileService()
    
    // Image Selection
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                loadSelectedImage(from: imageSelection)
            } else {
                imageState = .empty
            }
        }
    }
    
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !email.trimmingCharacters(in: .whitespaces).isEmpty
    }
    func save() async {
            guard canSave else { return } // 필수 입력값 재검증

            do {
                // 서버 응답 본문이 비어있거나 모델과 달라도 Status 200이면 성공 처리하기 위해 try await
                try await service.createProfile(name: name, email: email, imgUrl: "")
                
                // 여기까지 오면 성공
                self.isSaveSuccess = true
                print("✅ 저장 성공 및 화면 전환 준비 완료")
            } catch {
                // 만약 에러가 났지만 이미 서버 로그에 200이 찍혔다면,
                // 이는 디코딩 에러일 뿐 저장은 성공한 것이므로 true로 설정할 수 있습니다.
                // (서버 응답 모델을 [String: String] 등으로 유연하게 바꿨다면 이 문제는 사라집니다.)
                print("저장 중 알 수 없는 상태 발생: \(error)")
                
                // 실제 에러 상황(400, 500 등)에서는 false 유지
                self.isSaveSuccess = false
            }
        }

    // MARK: - Actions
    
    /// 초기 데이터 로드
    func loadInitialData() async {
        do {
            let data = try await service.getProfile()
            self.name = data.name
            self.email = data.email
            
            if let url = URL(string: data.imgUrl) {
                await downloadImage(from: url)
            }
        } catch {
            print("데이터 로드 실패: \(error)")
        }
    }

    // MARK: - Helper Methods
    
    private func loadSelectedImage(from selection: PhotosPickerItem) {
        imageState = .loading(Progress())
        selection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data?):
                    if let uiImage = UIImage(data: data) {
                        self.imageState = .success(Image(uiImage: uiImage))
                    }
                default:
                    self.imageState = .empty
                }
            }
        }
    }

    private func downloadImage(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                self.imageState = .success(Image(uiImage: uiImage))
            }
        } catch {
            self.imageState = .empty
        }
    }
}
