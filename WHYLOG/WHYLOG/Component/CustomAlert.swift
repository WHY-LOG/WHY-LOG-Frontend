//
//  CustomAlert.swift
//  WHYLOG
//
//  Created by 원서우 on 12/19/25.
//

import Foundation
import SwiftUI

struct CustomAlert: View {
    let title: String
    let message: String?
    let action: () -> Void
    let cancelAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(Color.grayC5C5C5)
                
                VStack(spacing: 8) {
                    Text(title)
                        .font(.PretendardBold16)
                        .foregroundStyle(Color.gray525252)
                    if let message = message {
                        Text(message)
                            .font(.PretendardMedium12)
                            .foregroundStyle(Color.gray525252)
                    }
                }
                
                HStack(spacing: 12) {
                    Button("취소") { cancelAction() }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.grayE3E3E3.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundStyle(Color.gray525252)
                    
                    Button("확인") { action() }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentCoral)
                        .cornerRadius(12)
                        .foregroundStyle(.white)
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 40)
        }
    }
}
