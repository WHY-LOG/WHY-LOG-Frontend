//
//  ProfileService.swift
//  WHYLOG
//
//  Created by 김종수 on 12/21/25.
//

import Foundation

struct ProfileService {
    private let userId: Int = 17
    
    func createProfile(name: String, email: String, imgUrl: String) async throws {
        let profile = UserProfileResponse(name: name, email: email, imgUrl: imgUrl)
        let body = try JSONEncoder().encode(profile)
        
        let _: UserProfileResponse = try await NetworkClient.request(
            endpoint: .createUser,
            body: body
        )
    }

    /// 서버에서 프로필 정보 가져오기
    func getProfile() async throws -> UserProfileResponse {
            // ✅ APIResponse<UserProfileResponse> 형태로 전체를 받아야 합니다.
            let response: APIResponse<UserProfileResponse> = try await NetworkClient.request(
                endpoint: .fetchUser(userId: userId)
            )
            
            // ✅ 그 안의 success 필드에 들어있는 실제 유저 데이터를 반환합니다.
            guard let profile = response.success else {
                throw NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "서버 응답의 success 데이터가 없습니다."])
            }
            
            return profile
        }

        // 수정(update) 시에도 마찬가지로 응답 형태를 맞춰주면 안전합니다.
        func updateProfile(name: String, email: String, imgUrl: String) async throws {
            let profile = UserProfileResponse(name: name, email: email, imgUrl: imgUrl)
            let body = try JSONEncoder().encode(profile)
            
            let _: APIResponse<UserProfileResponse> = try await NetworkClient.request(
                endpoint: .updateUser(userId: userId),
                body: body
            )
        }
    func deleteProfile() async throws {
        let _: APIResponse<String> = try await NetworkClient.request(
            endpoint: .deleteUser(userId: userId)
        )
    }
}
