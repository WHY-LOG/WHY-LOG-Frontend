//
//  ProfileService.swift
//  WHYLOG
//
//  Created by 김종수 on 12/21/25.
//

import Foundation

struct ProfileService {
    private let userId: Int = 7
    
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
        return try await NetworkClient.request(endpoint: .fetchUser(userId: userId))
    }

    /// 서버에 프로필 정보 업데이트하기
    func updateProfile(name: String, email: String, imgUrl: String) async throws {
        let profile = UserProfileResponse(name: name, email: email, imgUrl: imgUrl)
        let body = try JSONEncoder().encode(profile)
        
        let _: UserProfileResponse = try await NetworkClient.request(
            endpoint: .updateUser(userId: userId),
            body: body
        )
    }
}
