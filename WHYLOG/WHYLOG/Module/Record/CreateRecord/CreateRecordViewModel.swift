//
//  CreateRecordViewModel.swift
//  WHYLOG
//
//  Created by 원서우 on 12/18/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class CreateRecordViewModel: ObservableObject {
    // MARK: - Mode State
    @Published var isEditMode: Bool = false
    @ObservedObject var userSession = UserSession.shared // ✅ 추가
    var targetRecordId: Int?
    
    // MARK: - UI State
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

    // MARK: - 수정 모드 설정
    func setupEditMode(with record: RecordDTO) {
        self.isEditMode = true
        self.targetRecordId = record.recordId
        self.whatHappened = record.title
        self.whyAction = record.content
        
        // 날짜 변환 ("2025-12..." -> "2025. 12")
        let components = record.occurDate.components(separatedBy: "-")
        if components.count >= 2 {
            let month = Int(components[1].filter { $0.isNumber }) ?? 1
            self.selectedMonth = "2025. \(month)"
        }

        // 카테고리 매칭
        let serverCategoryNames = record.categories.map { $0.categoryName }
            
            for index in emotions.indices {
                if serverCategoryNames.contains(emotions[index].text) {
                    emotions[index].state = .selected
                }
            }
    }

    func uploadRecord() {
        guard isDateSelected, !whatHappened.isEmpty, !whyAction.isEmpty else { return }
        
        if isEditMode {
            updateRecord()
        } else {
            createRecord()
        }
    }

    private func createRecord() {
        self.isLoading = true
        let finalOccurDate = formatMonthForAPI()
        let selectedCategoryIds = getSelectedCategoryIds()
        let currentUserId = UserSession.shared.userId ?? 17
        
        Task {
            do {
                _ = try await RecordService.shared.createRecord(
                    userId: currentUserId,
                    title: whatHappened,
                    content: whyAction,
                    occurDate: finalOccurDate,
                    categoryIds: selectedCategoryIds
                )
                print("✅ 생성 성공: \(finalOccurDate)")
                self.isSuccess = true
            } catch {
                print("❌ 생성 실패 상세: \(error)")
            }
            self.isLoading = false
        }
    }

    private func updateRecord() {
        guard let recordId = targetRecordId else { return }
        self.isLoading = true
        let finalOccurDate = formatMonthForAPI()
        let selectedCategoryIds = getSelectedCategoryIds()
        let currentUserId = UserSession.shared.userId ?? 17
        
        Task {
            do {
                _ = try await RecordService.shared.updateRecord(
                    userId: currentUserId,
                    recordId: recordId,
                    title: whatHappened,
                    content: whyAction,
                    occurDate: finalOccurDate,
                    categoryIds: selectedCategoryIds
                )
                print("✅ 수정 성공: \(recordId)")
                self.isSuccess = true
            } catch {
                print("❌ 수정 실패 상세: \(error)")
            }
            self.isLoading = false
        }
    }

    private func formatMonthForAPI() -> String {
        let monthString = selectedMonth.components(separatedBy: ".").last?.filter { $0.isNumber } ?? ""
        let monthInt = Int(monthString) ?? 1
        return String(format: "2025-%02d", monthInt)
    }

    private func getSelectedCategoryIds() -> [Int] {
        return emotions.enumerated()
            .filter { $0.element.state == .selected || $0.element.state == .completed }
            .map { $0.offset + 1 }
    }
}
