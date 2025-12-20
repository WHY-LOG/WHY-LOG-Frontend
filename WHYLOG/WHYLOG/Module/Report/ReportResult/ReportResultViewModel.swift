//
//  ReportResultViewModel.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

//
//  ReportResultViewModel.swift
//  WHYLOG
//

import Foundation
import Combine

@MainActor
final class ReportResultViewModel: ObservableObject {

    // MARK: - View State
    @Published var year: Int = 0
    @Published var dominantTypes: [String] = []
    @Published var summaryText: String = ""
    @Published var standardText: String = ""
    @Published var graphItems: [EmotionGraphItem] = []

    // MARK: - Mock (API 붙이기 전)
    func loadMock(year: Int) {
        self.year = year
        self.dominantTypes = ["회피", "책임감"]

        self.summaryText =
        "\(year)년 당신의 판단은\n회피(40%)와 책임감(30%)에서 시작되었습니다."

        self.standardText =
        "당신은 반복된 선택을 통해 자신만의 판단 기준을 만들어가고 있습니다."

        self.graphItems = [
            EmotionGraphItem(type: .avoidance, ratio: 0.4),
            EmotionGraphItem(type: .responsibility, ratio: 0.3),
            EmotionGraphItem(type: .expectation, ratio: 0.2),
            EmotionGraphItem(type: .fear, ratio: 0.1)
        ]
    }
}


