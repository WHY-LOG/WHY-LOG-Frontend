////
////  ReportService.swift
////  WHYLOG
////
////  Created by 김진서 on 12/20/25.
////
//
//import Foundation
//
//struct ReportService {
//
//    func fetchReport(userId: Int, year: Int) async throws -> ReportResultDTO {
//
//        let endpoint = APIEndpoint.fetchReport(userId: userId, year: year)
//
//        let response: ReportResultResponse = try await NetworkClient.request(
//            endpoint: endpoint
//        )
//
//        return response.result
//    }
//}
