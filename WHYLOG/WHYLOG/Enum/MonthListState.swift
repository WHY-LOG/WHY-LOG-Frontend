//
//  MonthListState.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation

enum MonthListState: Int, CaseIterable {
    case Jan = 1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
    
    var MonthCap: String {
        return String(describing: self) // "Jan", "Feb" 등을 자동으로 가져옴
    }
    
    var MonthNumber: String {
        return "\(self.rawValue)" // 1, 2, 3... 번호를 가져옴
    }
}
