//
//  UserProfileResponse.swift
//  WHYLOG
//
//  Created by 김종수 on 12/21/25.
//

import Foundation

// 서버의 전체 응답 구조
struct APIResponse<T: Codable>: Codable {
    let resultType: String
    let error: String?
    let success: T?
}

// 실제 유저 데이터 구조
struct UserProfileResponse: Codable {
    let userId: Int?  // GET 시에는 있고, PUT/POST 시에는 body에 없을 수 있으므로 옵셔널
    var name: String
    var email: String
    var imgUrl: String?

    // API 전송용 이니셜라이저
    init(name: String, email: String, imgUrl: String) {
        self.userId = nil
        self.name = name
        self.email = email
        self.imgUrl = imgUrl
    }
}
