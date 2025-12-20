//
//  ReportDTO.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//


import Foundation

// MARK: - Report List Item (리포트 목록용)
struct ReportListItemDTO: Decodable {
    let reportId: Int
    let year: Int
}

// MARK: - Report Result (리포트 결과 상세)
struct ReportResultDTO: Decodable {
    let reportId: Int
    let year: Int
    let standard: String
    let content: String
    let graphData: [GraphDataDTO]
}

// MARK: - Graph Data
struct GraphDataDTO: Decodable {
    let categoryId: Int
    let categoryName: String
    let count: Int
    let percent: Int
}

// MARK: - Create Report Request
struct CreateReportRequest: Encodable {
    let year: Int
}

