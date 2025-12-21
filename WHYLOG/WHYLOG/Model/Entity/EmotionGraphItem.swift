//
//  EmotionGraphItem.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import Foundation
import CoreGraphics

struct EmotionGraphItem: Identifiable {
    let id = UUID()
    let type: EmotionType
    let ratio: CGFloat // 0.0 ~ 1.0
}
