//
//  DetailedRecordViewModel.swift
//  WHYLOG
//
//  Created by 원서우 on 12/21/25.
//

import Foundation
import Combine

@MainActor
class DetailedRecordViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    func deleteRecord(userId: Int, recordId: Int) async -> Bool {
        self.isLoading = true
        do {
            // 백엔드 가이드에 따라 userId 5를 사용하여 삭제를 요청합니다.
            _ = try await RecordService.shared.deleteRecord(userId: 5, recordId: recordId)
            self.isLoading = false
            return true
        } catch {
            print("❌ 삭제 실패: \(error)")
            self.isLoading = false
            return false
        }
    }
}
