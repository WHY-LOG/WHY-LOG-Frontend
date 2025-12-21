//
//  RecordDTO.swift
//  WHYLOG
//
//  Created by 김진서 on 12/21/25.
//

import Foundation

// MARK: - Request

//생성 (POST)
struct CreateRecordRequest: Encodable {
    let title: String
    let content: String
    let categoryIds: [Int]
    let occurDate: String

    enum CodingKeys: String, CodingKey {
        case title
        case content
        case categoryIds = "category"
        case occurDate
    }
}

//수정 (PUT)
struct UpdateRecordRequest: Encodable {
    let title: String
    let content: String
    let categoryIds: [Int]
    let occurDate: String

    enum CodingKeys: String, CodingKey {
        case title
        case content
        case categoryIds = "category"
        case occurDate
    }
}


// MARK: - Response

// 공통 Response
struct RecordBaseResponse<T: Decodable>: Decodable {
    let resultType: String
    let error: String?
    let success: T
}

// 타입 별칭 정의
typealias FetchRecordsResponse = RecordBaseResponse<[RecordDTO]>
typealias CreateRecordResponse = RecordBaseResponse<RecordDTO>
typealias UpdateRecordResponse = RecordBaseResponse<RecordDTO>
typealias DeleteRecordResponse = RecordBaseResponse<Int>


// MARK: - Record DTO

struct RecordDTO: Decodable {
    let recordId: Int
    let title: String
    let content: String
    let occurDate: String
    let categories: [String]

    enum CodingKeys: String, CodingKey {
        case recordId = "id"
        case title
        case content
        case occurDate
        case categories
    }
}

extension RecordDTO: Identifiable {
    // 서버가 주는 recordId를 SwiftUI의 id로 쓰겠다고 선언 (서버 데이터 안 바뀜)
    var id: Int {
        return self.recordId
    }
}
