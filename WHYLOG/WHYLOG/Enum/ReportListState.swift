//
//  ReportListState.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

enum ReportListState {
    case empty
    case loaded([Int])
    case networkError
}
