//
//  ChipButton.swift
//  WHYLOG
//
//  Created by 원서우 on 12/18/25.
//

import Foundation
import SwiftUI


struct ChipButton: View {
    let text: String
    @Binding var state: ChipState

    var body: some View {
        Button(action: {
            if state == .unselected {
                state = .selected
            } else if state == .selected {
                state = .unselected
            }
        }) {
            Text(text)
                .font(.PretendardSemiBold16)
                .padding(.horizontal, 21)
                .frame(height: 37)
                .foregroundColor(textColor) //foregroundStyle
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(backgroundColor)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(borderColor, lineWidth: 1)
                )
        }
        .disabled(state == .completed)
    }
    
    // 1. 글자 색상
    var textColor: Color {
        switch state {
        case .unselected:
            return Color.gray525252
        case .selected:
            return Color(red: 1, green: 0.55, blue: 0)
        case .completed:
            return Color(red: 0.32, green: 0.32, blue: 0.32)
        }
    }
    
    // 2. 배경 색상
    var backgroundColor: Color {
        switch state {
        case .unselected:
            return Color.white
        case .selected:
            return Color.accentOrange
        case .completed:
            return Color.accentOrange
        }
    }
    
    // 3. 테두리 색상
    var borderColor: Color {
        switch state {
        case .unselected:
            return Color.grayC5C5C5
        case .selected:
            return Color(red: 1, green: 0.55, blue: 0)
        case .completed:
            return Color.clear
        }
    }
}
