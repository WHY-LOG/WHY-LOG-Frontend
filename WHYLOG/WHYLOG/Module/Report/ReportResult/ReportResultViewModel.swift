//
//  ReportResultViewModel.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import Foundation
import Combine

@MainActor
final class ReportResultViewModel: ObservableObject {

    @Published var report: ReportResultDTO?
    @Published var dominantTypes: [String] = []

    private let reportService = ReportService()

    // MARK: - Load
    func loadReport(userId: Int, year: Int) async {
        do {
            let report = try await reportService.fetchReport(
                userId: userId,
                year: year
            )

            self.report = report
            calculateDominantTypes(from: report.graphData)

        } catch {
            print("❌ Failed to load report:", error)
        }
    }

    // MARK: - Business Logic
    private func calculateDominantTypes(from data: [GraphDataDTO]) {
        let maxPercent = data.map { $0.percent }.max() ?? 0

        dominantTypes = data
            .filter { $0.percent == maxPercent }
            .map { $0.categoryName }
    }
}
