//
//  ReportService.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import Foundation


final class ReportService {

    // MARK: - 리포트 목록 조회
    func fetchReports(userId: Int) async throws -> [ReportListItemDTO] {

        struct FetchReportsResponse: Decodable {
            let result: [ReportListItemDTO]
        }

        let response: FetchReportsResponse = try await NetworkClient.request(
            endpoint: .fetchReports(userId: userId)
        )

        return response.result
    }


    // MARK: - 리포트 생성
    func createReport(userId: Int, year: Int) async throws -> ReportResultDTO {
        struct Response: Decodable {
            let result: ReportResultDTO
        }

        let bodyData = try JSONEncoder().encode(
            CreateReportRequest(year: year)
        )

        let response: Response = try await NetworkClient.request(
            endpoint: .createReport(userId: userId),
            body: bodyData
        )

        return response.result
    }



    // MARK: - 리포트 결과 조회
    func fetchReportResult(
        userId: Int,
        year: Int
    ) async throws -> ReportResultDTO {

        struct Response: Decodable {
            let result: [ReportResultDTO]
        }

        let response: Response =
            try await NetworkClient.request(
                endpoint: .fetchReports(userId: userId)
            )

        guard let report = response.result.first(where: { $0.year == year }) else {
            throw NSError(domain: "ReportNotFound", code: 404)
        }

        return report
    }

}
