//
//  ReportListViewModel.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import SwiftUI
import Combine

@MainActor
final class ReportListViewModel: ObservableObject {
    @Published var state: ReportListState = .empty

    func fetchReports() async {

        do {
            // 나중에 실제 API 호출
            try await Task.sleep(nanoseconds: 1_000_000_000)

            let reports: [Int] = [] // 예: API 결과

            if reports.isEmpty {
                state = .empty
            } else {
                state = .loaded(reports)
            }

        } catch {
            state = .networkError
        }
    }
}
