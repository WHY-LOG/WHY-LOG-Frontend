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
    
    // MARK: - Summary Text
    var summaryText: String {
        guard let report = report else { return "" }

        let topTwo = report.graphData
            .sorted { $0.percent > $1.percent }
            .prefix(2)

        let text = topTwo
            .map { "\($0.categoryName)(\($0.percent)%)" }
            .joined(separator: "와 ")

        return "\(report.year)년 당신의 판단은\n\(text)에서 시작되었습니다."
    }

    // MARK: - AI 답변
    var standardText: String {
        report?.standard ?? ""
    }
}


