//
//  CreateRecordViewModel.swift
//  WHYLOG
//
//  Created by 원서우 on 12/18/25.
//

import Foundation
import Combine

class CreateRecordViewModel: ObservableObject {
    //감정
    @Published var emotions: [EmotionItem] = [
        EmotionItem(text: "비교", state: .unselected),
        EmotionItem(text: "두려움", state: .unselected),
        EmotionItem(text: "기대", state: .unselected),
        EmotionItem(text: "회피", state: .unselected),
        EmotionItem(text: "즉각적 만족", state: .unselected),
        EmotionItem(text: "책임감", state: .unselected),
    ]
    
    func completeRecord() {
        for index in emotions.indices {
            if emotions[index].state == .selected {
                emotions[index].state = .completed
            }
        }
    }
    
    //달력
    @Published var selectedMonth: String = "날짜 선택"
    @Published var showMonthGraph: Bool = false
    
    var isDateSelected: Bool {
            selectedMonth != "날짜 선택"
        }
    
    //기록
    @Published var whatHappened: String = ""
    @Published var whyAction: String = ""
}
