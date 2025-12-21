//
//  RecordDTO.swift
//  WHYLOG
//
//  Created by 김진서 on 12/21/25.
//

import Foundation

// MARK: - Request (전송용)
struct CreateRecordRequest: Encodable {
    let title: String
    let content: String
    let category: [Int] // 명세서 Body 키값 "category"에 맞춤
    let occurDate: String
    
    enum CodingKeys: String, CodingKey {
        case title, content, occurDate
        case category // 서버에서 categoryIds가 아닌 category를 기대할 경우
    }
}

struct UpdateRecordRequest: Encodable {
    let title: String
    let content: String
    let category: [Int]
    let occurDate: String
    
    enum CodingKeys: String, CodingKey {
        case title, content, occurDate
        case category
    }
}

// MARK: - Response Base (공통 응답)
struct RecordBaseResponse<T: Decodable>: Decodable {
    let resultType: String
    let error: String?
    let success: T
}

typealias FetchRecordsResponse = RecordBaseResponse<[RecordDTO]>
typealias CreateRecordResponse = RecordBaseResponse<RecordDTO>
typealias UpdateRecordResponse = RecordBaseResponse<RecordDTO>
typealias DeleteRecordResponse = RecordBaseResponse<Int>

// MARK: - Record DTO (수신용)
struct RecordDTO: Decodable, Identifiable {
    let recordId: Int
    let title: String
    let content: String
    let occurDate: String
    let categories: [CategoryDTO] // 객체 배열 구조 반영

    enum CodingKeys: String, CodingKey {
        case recordId = "RecordId" // 스웨거의 대문자 키값 반영
        case title
        case content
        case occurDate
        case categories
    }

    var id: Int { return recordId }
    
    // UI에서 이름을 바로 쓰기 위한 편의 변수
    var categoryNames: [String] {
        return categories.map { $0.categoryName }
    }
}

struct CategoryDTO: Decodable {
    let categoryId: Int
    let categoryName: String
}
