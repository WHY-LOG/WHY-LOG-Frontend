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
    // MARK: - UI State
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var imgUrl: String = ""
    @Published var isSaveSuccess: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published private(set) var imageState: ProfileModel.ImageState = .empty
    
    // MARK: - Dependencies
    private let service = ProfileService()
    
    // MARK: - Image Selection
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                loadSelectedImage(from: imageSelection)
            } else {
                imageState = .empty
            }
        }
    }
    
    // 유효성 검사
    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !email.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - API Actions

    /// 1. 프로필 초기 생성 (POST) - 회원가입/초기설정 시 사용
    func save() async {
        guard canSave else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            try await service.createProfile(name: name, email: email, imgUrl: imgUrl)
            self.isSaveSuccess = true
            print("✅ 프로필 생성 성공")
        } catch {
            self.errorMessage = "저장 중 에러 발생: \(error.localizedDescription)"
            self.isSaveSuccess = false
        }
    }

    /// 2. 프로필 정보 가져오기 (GET) - 마이페이지 진입 시 사용
    func fetchProfile() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let data = try await service.getProfile()
            self.name = data.name
            self.email = data.email
            self.imgUrl = data.imgUrl ?? ""
            
            print("✅ 데이터 로드 성공: 이름=\(self.name), 이메일=\(self.email)")
            
            if let urlString = data.imgUrl, let url = URL(string: urlString) {
                await downloadImage(from: url)
            }
        } catch {
            self.errorMessage = "데이터 로드 실패: \(error.localizedDescription)"
        }
    }

    /// 3. 프로필 정보 업데이트 (PUT) - 마이페이지 수정 완료 시 사용
    func updateProfile() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await service.updateProfile(name: name, email: email, imgUrl: imgUrl)
            print("✅ 프로필 수정 성공")
        } catch {
            self.errorMessage = "수정 실패: \(error.localizedDescription)"
        }
    }

    /// 4. 프로필 삭제 (DELETE)
    func deleteProfile() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await service.deleteProfile()
            self.name = ""
            self.email = ""
            self.imgUrl = ""
            self.imageState = .empty
                    
            print("✅ 프로필 삭제 및 로컬 데이터 초기화 완료")
            return true
        } catch {
            self.errorMessage = "삭제 실패: \(error.localizedDescription)"
            return false
        }
    }

    // MARK: - Helper Methods (Image)
    
    private func loadSelectedImage(from selection: PhotosPickerItem) {
        imageState = .loading(Progress())
        selection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data?):
                    if let uiImage = UIImage(data: data) {
                        self.imageState = .success(Image(uiImage: uiImage))
                        // TODO: 필요시 여기서 이미지 서버 업로드 API 호출
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
