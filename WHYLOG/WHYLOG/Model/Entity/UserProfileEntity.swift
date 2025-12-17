//
//  2.swift
//  WHYLOG
//
//  Created by 김종수 on 12/16/25.
//

import Foundation

struct UserProfile{
    let name: String
    let Email: String
    let profileImageURL: String?
    
    var isProfileComplete: Bool{
        !name.isEmpty && !Email.isEmpty
    }
}
