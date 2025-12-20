//
//  File.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import Foundation
import Combine

@MainActor
final class ReportStore: ObservableObject {
    @Published private(set) var reports: Set<Int> = []

    func hasReport(year: Int) -> Bool {
        reports.contains(year)
    }

    func createReport(year: Int) {
        reports.insert(year)
    }
}
