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

    @Published var reports: [ReportListItemDTO] = []
    @Published var isLoading = false
    @Published var hasError = false

    private let reportService = ReportService()

    func load(userId: Int) async {
        isLoading = true
        hasError = false

        do {
            let response = try await reportService.fetchReports(userId: userId)
            self.reports = response
        } catch {
            hasError = true
            print("❌ Report list load failed:", error)
        }

        isLoading = false
    }
}

