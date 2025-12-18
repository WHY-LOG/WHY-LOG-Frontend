//
//  EmotionItem.swift
//  WHYLOG
//
//  Created by 원서우 on 12/18/25.
//

import Foundation

enum ChipState {
    case unselected // 선택 안 됨
    case selected   // 선택 됨
    case completed  // 완료
}

struct EmotionItem: Identifiable {
    let id = UUID()
    let text: String
    var state: ChipState
}
