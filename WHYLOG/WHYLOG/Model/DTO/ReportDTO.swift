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

// MARK: - Report Result (GET 결과 조회용)
struct ReportResultDTO: Decodable {
    let reportId: Int?
    let year: Int
    let standard: String
    let content: String
    let graphData: [GraphDataDTO]
}

// MARK: - Graph Data
struct GraphDataDTO: Decodable {
    let categoryId: Int
    let categoryName: String
    let percent: Int
}

// MARK: - Create Report Response (POST 전용 DTO)
struct CreateReportResultDTO: Decodable {
    let year: Int
    let standard: String
    let graphData: [GraphDataDTO]
}

struct CreateReportResponse: Decodable {
    let result: CreateReportResultDTO
}

// MARK: - Create Report Request (POST Body)
struct CreateReportRequest: Encodable {
    let year: Int
}

// MARK: - Update Report Request
struct UpdateReportRequest: Encodable {
    let content: String
}
