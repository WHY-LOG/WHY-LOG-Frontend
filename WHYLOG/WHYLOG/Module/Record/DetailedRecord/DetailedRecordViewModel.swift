//
//  DetailedRecordViewModel.swift
//  WHYLOG
//
//  Created by 원서우 on 12/21/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class DetailedRecordViewModel: ObservableObject {
    @Published var record: RecordDTO?
    @Published var isLoading: Bool = false
    
    func deleteRecord(userId: Int, recordId: Int) async -> Bool {
        self.isLoading = true
        do {
            _ = try await RecordService.shared.deleteRecord(userId: userId, recordId: recordId)
            self.isLoading = false
            return true
        } catch {
            print("삭제 실패: \(error)")
            self.isLoading = false
            return false
        }
    }
}
