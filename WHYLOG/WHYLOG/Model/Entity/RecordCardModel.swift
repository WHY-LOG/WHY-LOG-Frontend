//
//  RememberCardModel.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation

struct RecordCardModel: Identifiable {
    let id: UUID = UUID()
    let year: Int
    let month: String
    let title: String
    let content: String
    let emotion: [String]
}

let mockLogs: [RecordDTO] = [
    RecordDTO(
        recordId: 1,
        title: "화해하지 못한 기록",
        content: "자존심 때문에 소중한 인연을 놓칠 뻔 했다.",
        occurDate: "2025-03",
        categories: [CategoryDTO(categoryId: 4, categoryName: "회피")]
    )
]
