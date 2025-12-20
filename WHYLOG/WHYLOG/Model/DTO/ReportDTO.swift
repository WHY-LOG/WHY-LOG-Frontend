//
//  ReportDTO.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import Foundation

// MARK: - 공통 Response
struct ReportBaseResponse<T: Decodable>: Decodable {
    let resultType: String
    let error: String?
    let success: T
}

// MARK: - fetchReports
typealias FetchReportsResponse = ReportBaseResponse<[ReportDTO]>

// MARK: - create / update / delete
typealias CreateReportResponse = ReportBaseResponse<ReportDTO>
typealias UpdateReportResponse = ReportBaseResponse<ReportDTO>
typealias DeleteReportResponse = ReportBaseResponse<EmptyResponse>

// MARK: - Report DTO
struct ReportDTO: Decodable {
    let reportId: Int
    let title: String
    let year: Int
    let createdAt: String
}

// MARK: - Report 생성 / 수정 Request
struct ReportRequest: Encodable {
    let title: String
    let year: Int
}
