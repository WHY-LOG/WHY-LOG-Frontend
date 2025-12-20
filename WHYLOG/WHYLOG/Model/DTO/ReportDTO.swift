//
//  ReportDTO.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import Foundation

// MARK: - Report List
struct ReportDTO: Decodable {
    let reportId: Int
    let year: Int
}

// MARK: - Report Result
struct ReportResultDTO: Decodable {
    let year: Int
    let standard: String
    let graphData: [GraphDataDTO]
}

struct GraphDataDTO: Decodable {
    let categoryName: String
    let percent: Int
    let count: Int?
}

// MARK: - Request
struct CreateReportRequest: Encodable {
    let year: Int
}

