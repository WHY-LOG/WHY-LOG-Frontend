//
//  ReportListViewModel.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import Foundation
import Combine

@MainActor
final class ReportListViewModel: ObservableObject {

    /// 생성된 리포트 연도 목록
    @Published var years: [Int] = []

    // MARK: - Mock
    func loadMock() {
        years = [2025]
    }

    // MARK: - API (나중에)
    /*
    func fetchReports(userId: Int) async throws {
        let response = try await reportService.fetchReports(userId: userId)
        years = response.map { $0.year }
    }
    */
}
