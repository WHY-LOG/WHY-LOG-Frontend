//
//  UserSession.swift
//  WHYLOG
//
//  Created by 김종수 on 12/21/25.
//

import Foundation
import Combine

class UserSession: ObservableObject {
    static let shared = UserSession()
    
    // 외부에서 UserSession.shared.userId 로 접근
    @Published var userId: Int? {
        didSet {
            // ID가 변경될 때마다 저장
            if let id = userId {
                UserDefaults.standard.set(id, forKey: "current_user_id")
            } else {
                UserDefaults.standard.removeObject(forKey: "current_user_id")
            }
        }
    }
    
    private init() {
        let savedId = UserDefaults.standard.integer(forKey: "current_user_id")
        // UserDefaults integer는 값이 없으면 0을 반환하므로 체크
        self.userId = savedId != 0 ? savedId : nil
    }
}
