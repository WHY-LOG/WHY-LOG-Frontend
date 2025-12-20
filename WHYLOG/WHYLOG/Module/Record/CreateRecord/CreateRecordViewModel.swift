//
//  CreateRecordViewModel.swift
//  WHYLOG
//
//  Created by 원서우 on 12/18/25.
//

import Foundation
import Combine

@MainActor // UI 업데이트를 위해 MainActor 유지
class CreateRecordViewModel: ObservableObject {
    
    // MARK: - UI State
    
    // 감정
    @Published var emotions: [EmotionItem] = [
        EmotionItem(text: "비교", state: .unselected),
        EmotionItem(text: "두려움", state: .unselected),
        EmotionItem(text: "기대", state: .unselected),
        EmotionItem(text: "회피", state: .unselected),
        EmotionItem(text: "즉각적 만족", state: .unselected),
        EmotionItem(text: "책임감", state: .unselected),
    ]
    
    // 달력
    @Published var selectedMonth: String = "날짜 선택"
    @Published var showMonthGraph: Bool = false
    
    var isDateSelected: Bool {
        selectedMonth != "날짜 선택"
    }
    
    // 기록 (제목, 내용)
    @Published var whatHappened: String = "" // -> title로 매핑
    @Published var whyAction: String = ""    // -> content로 매핑
    
    // MARK: - API State (새로 추가된 부분)
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false // true -> View에서 화면 닫음
    @Published var errorMessage: String? = nil
    
    
    // MARK: - Logic
    
    func completeRecord() {
        for index in emotions.indices {
            if emotions[index].state == .selected {
                emotions[index].state = .completed
            }
        }
    }
    
    func uploadRecord() {
        // 유효성 검사
        guard isDateSelected, !whatHappened.isEmpty, !whyAction.isEmpty else {
            print("입력되지 않은 값이 있습니다.")
            return
        }
        
        self.isLoading = true
        
        // 데이터 변환
        let selectedCategoryIds = emotions.enumerated()
            .filter { $0.element.state == .selected || $0.element.state == .completed }
            .map { $0.offset + 1 }
        
        // API 호출
        Task {
            do {
                // ⚠️ 테스트용 userId = 1 (로그인 구현 후 실제 ID로 교체 필요)
                let userId = 1
                
                // Service 호출
                let _ = try await RecordService.shared.createRecord(
                    userId: userId,
                    title: whatHappened,
                    content: whyAction,
                    occurDate: selectedMonth,
                    categoryIds: selectedCategoryIds
                )
                
                print("기록 생성 성공!")
                self.isSuccess = true
                self.completeRecord()
                
            } catch {
                print("기록 생성 실패: \(error)")
                self.errorMessage = "기록 저장에 실패했습니다."
            }
            
            self.isLoading = false
        }
    }
}
