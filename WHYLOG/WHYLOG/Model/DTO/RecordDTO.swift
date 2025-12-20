//
//  RecordDTO.swift
//  WHYLOG
//
//  Created by 김진서 on 12/21/25.
//

import Foundation

// 공통 Response
struct RecordBaseResponse<T: Decodable>: Decodable {
    let resultType: String
    let error: String?
    let success: T
}

// fetchRecords 전용 타입 별칭
typealias FetchRecordsResponse = RecordBaseResponse<[RecordDTO]>

// Record
struct RecordDTO: Decodable {
    let recordId: Int
    let title: String
    let content: String
    let occurDate: String
    let categories: [RecordCategoryDTO]

    enum CodingKeys: String, CodingKey {
        case recordId = "RecordId"
        case title
        case content
        case occurDate
        case categories
    }
}

struct RecordCategoryDTO: Decodable {
    let categoryId: Int
    let categoryName: String
}
