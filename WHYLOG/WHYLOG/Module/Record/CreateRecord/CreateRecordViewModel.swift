//
//  CreateRecordViewModel.swift
//  WHYLOG
//
//  Created by 원서우 on 12/18/25.
//

import Foundation
import Combine

@MainActor
class CreateRecordViewModel: ObservableObject {
    @Published var emotions: [EmotionItem] = [
        EmotionItem(text: "비교", state: .unselected),
        EmotionItem(text: "두려움", state: .unselected),
        EmotionItem(text: "기대", state: .unselected),
        EmotionItem(text: "회피", state: .unselected),
        EmotionItem(text: "즉각적 만족", state: .unselected),
        EmotionItem(text: "책임감", state: .unselected),
    ]
    
    @Published var selectedMonth: String = "날짜 선택"
    @Published var showMonthGraph: Bool = false
    @Published var whatHappened: String = ""
    @Published var whyAction: String = ""
    
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false

    var isDateSelected: Bool { selectedMonth != "날짜 선택" }

    func uploadRecord() {
        guard isDateSelected, !whatHappened.isEmpty, !whyAction.isEmpty else { return }
        self.isLoading = true
        
        // 1. 날짜 포맷팅: "2025. 3" -> "2025-03" (Swagger/명세서 규격)
        let monthString = selectedMonth.components(separatedBy: ".").last?.filter { $0.isNumber } ?? ""
        let monthInt = Int(monthString) ?? 1
        let formattedMonth = String(format: "%02d", monthInt)
        let finalOccurDate = "2025-\(formattedMonth)" // 예: "2025-03"
        
        // 2. 카테고리 ID 추출 (선택된 항목들의 인덱스+1)
        let selectedCategoryIds = emotions.enumerated()
            .filter { $0.element.state == .selected }
            .map { $0.offset + 1 }
        
        Task {
            do {
                // 백엔드 확인 사항: userId를 5로 전송
                _ = try await RecordService.shared.createRecord(
                    userId: 5,
                    title: whatHappened,
                    content: whyAction,
                    occurDate: finalOccurDate,
                    categoryIds: selectedCategoryIds
                )
                print("✅ 생성 성공! 날짜: \(finalOccurDate)")
                self.isSuccess = true
            } catch {
                print("❌ 생성 실패: \(error)")
            }
            self.isLoading = false
        }
    }
}
