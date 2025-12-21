//
//  MonthSelectButton.swift
//  WHYLOG
//
//  Created by 원서우 on 12/19/25.
//

import Foundation
import SwiftUI

public struct MonthSelectButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                HStack {
                    Text(title)
                        .font(.PretendardMedium12)
                        .foregroundStyle(Color.gray949494)
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .foregroundStyle(Color.gray949494)
                }
                .padding(.horizontal, 17.7)
                .frame(width: 170, height: 41)
                .background(
                    RoundedRectangle(cornerRadius: 17.7)
                        .fill(Color.white)
                        .stroke(isSelected ? Color.gray949494 : Color.clear, lineWidth: 1.8)
                )
            }
        }
    }
}
