//
//  WHYLOGApp.swift
//  WHYLOG
//
//  Created by 김종수 on 12/16/25.
//

import SwiftUI

@main
struct WHYLOGApp: App {
    @StateObject private var reportStore = ReportStore()
    @StateObject private var profileModel = ProfileModel()

    
    var body: some Scene {
        WindowGroup {
            
            LoginView()
                .environmentObject(reportStore)
                .environmentObject(profileModel)
        }
    }
}
