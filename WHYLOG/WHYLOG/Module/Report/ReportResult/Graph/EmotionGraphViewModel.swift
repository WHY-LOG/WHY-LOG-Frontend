//
//  EmotionGraphViewModel.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import Foundation
import Combine
import CoreGraphics

final class EmotionGraphViewModel: ObservableObject {
    @Published var items: [EmotionGraphItem] = []

    // Mock 데이터
    func loadMock() {
        let rawCounts: [(EmotionType, Int)] = [
            (.compare, 100),
            (.fear, 200),
            (.expectation, 300),
            (.avoidance, 400),
            (.instant, 500),
            (.responsibility, 600)
        ]

        let maxCount = rawCounts.map { $0.1 }.max() ?? 1

        items = rawCounts.map { type, count in
            EmotionGraphItem(
                type: type,
                ratio: count == 0 ? 0 : CGFloat(count) / CGFloat(maxCount)
            )
        }
    }

    // 🔮 나중에 API 붙일 때 예시
    /*
    func loadFromAPI(data: [GraphData]) {
        items = data.map {
            EmotionGraphItem(
                type: EmotionType(rawValue: $0.categoryName)!,
                ratio: CGFloat($0.percent) / 100
            )
        }
    }
    */
}
