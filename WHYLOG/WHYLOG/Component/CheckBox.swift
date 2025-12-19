//
//  CheckBox.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

enum CheckBoxColor {
    case red
    case blue
    
    var backgroundColor: Color {
        switch self {
        case .red:
            return Color.intermediateCoral
        case .blue:
            return Color.baseBlue
        }
    }
    var textColor: Color {
        switch self {
            case .red:
                return Color.redFF694E
            case .blue:
                return Color.accentBlue
            }
        }
    var iconName : String {
        switch self {
        case .red:
            return "x.circle"
        case .blue:
            return "checkmark.circle"
        }
    }
    }

struct CheckBox: View{
    let title: String
    let theme: CheckBoxColor
    
    var body: some View {
        HStack{
            Text(title)
                .font(.PretendardMedium12)
                .foregroundColor(theme.textColor)
            Spacer()
            Image(systemName: theme.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .foregroundColor(theme.textColor)
            
        }
        .padding(.horizontal,24)
        .padding(.vertical,14)
        .background(theme.backgroundColor)
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(theme.textColor, lineWidth: 2)
        )
    }
}

