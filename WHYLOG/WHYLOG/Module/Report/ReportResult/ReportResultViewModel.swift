//
//  ReportResultViewModel.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import Foundation
import Combine
import CoreGraphics

@MainActor
final class ReportResultViewModel: ObservableObject {

    private let reportService = ReportService()
    @Published var year: Int = 0
    @Published var reportId: Int = 0
    @Published var content: String = ""

    // MARK: - View State (View가 직접 쓰는 값)
    /// 가장 많이 반복된 판단 동기 (ex. ["회피", "책임감"])
    @Published var dominantTypes: [String] = []
    
    /// 요약 문구용 데이터 (텍스트 + 퍼센트)
    /// ex) [("회피", 40), ("책임감", 30)]
    @Published var summaryHighlights: [(text: String, percent: Int)] = []
    
    /// AI 기준 설명 텍스트
    @Published var standardText: String = ""
    
    /// 그래프용 데이터 (항상 6개)
    @Published var graphItems: [EmotionGraphItem] = []
    
    func load(userId: Int, year: Int) async {
        do {
            let result = try await reportService.fetchReportResult(
                userId: userId,
                year: year
            )
            apply(result)
        } catch {
            print("❌ ReportResult load failed:", error)
        }
    }

    
    private func apply(_ result: ReportResultDTO) {
        // reportId
        self.reportId = result.reportId!
        
        // 연도
        self.year = result.year

        // AI 기준 텍스트
        self.standardText = result.standard
        
        self.content = result.content

        // 퍼센트 기준 정렬
        let sorted = result.graphData.sorted { $0.percent > $1.percent }

        // 요약용 (상위 2개)
        self.summaryHighlights = sorted.prefix(2).map {
            (text: $0.categoryName, percent: $0.percent)
        }

        // 가장 많이 반복된 판단 동기
        if let maxPercent = sorted.first?.percent {
            self.dominantTypes = sorted
                .filter { $0.percent == maxPercent }
                .map { $0.categoryName }
        }

        // 그래프용 (항상 6개)
        let counts: [EmotionType: Int] = Dictionary(
            uniqueKeysWithValues: result.graphData.compactMap { data in
                guard let type = EmotionType(rawValue: data.categoryName) else {
                    return nil
                }
                return (type, data.percent)
            }
        )


        self.graphItems = makeGraphItems(counts: counts)
        
    }



    // MARK: - 그래프 가공 (항상 6개 생성)
    private func makeGraphItems(
        counts: [EmotionType: Int]
    ) -> [EmotionGraphItem] {

        let total = counts.values.reduce(0, +)

        return EmotionType.allCases.map { type in
            let count = counts[type] ?? 0
            let ratio = total == 0 ? 0 : CGFloat(count) / CGFloat(total)

            return EmotionGraphItem(
                type: type,
                ratio: ratio
            )
        }
    }
    
    // MARK: - 다짐 내용 저장
    func updateContent(
        userId: Int,
        content: String
    ) async throws {
        try await reportService.updateReport(
            userId: userId,
            reportId: reportId, // load()에서 받은 값
            content: content
        )
    }
    
    // MARK: - 리포트 삭제
        func deleteReport(userId: Int) async throws {
            try await reportService.deleteReport(
                userId: userId,
                reportId: reportId
            )
        }

}
