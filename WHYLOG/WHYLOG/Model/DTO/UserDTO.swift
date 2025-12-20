//
//  UserDTO.swift
//  WHYLOG
//
//  Created by 김진서 on 12/21/25.
//


import Foundation

// MARK: - 공통 Response
struct UserBaseResponse<T: Decodable>: Decodable {
    let resultType: String
    let error: String?
    let success: T
}

// MARK: - User Response
typealias FetchUserResponse  = UserBaseResponse<UserDTO>
typealias CreateUserResponse = UserBaseResponse<UserDTO>
typealias UpdateUserResponse = UserBaseResponse<UserDTO>
typealias DeleteUserResponse = UserBaseResponse<EmptyResponse>

// MARK: - User DTO
struct UserDTO: Decodable {
    let userId: Int
    let name: String
    let email: String
    let createdAt: String
}

// MARK: - User Request
struct UserRequest: Encodable {
    let name: String
    let email: String
}
