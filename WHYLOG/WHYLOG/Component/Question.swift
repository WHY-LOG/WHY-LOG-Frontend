//
//  Question.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

enum QuestionNumber {
    case one
    case two
    case three
    case four
    case five
    case six
    
    var numberIcon: String {
        switch self {
        case .one:
            return "1.circle"
        case .two: return "2.circle"
        case .three: return "3.circle"
        case .four: return "4.circle"
        case .five: return "5.circle"
        case .six: return "6.circle"
        }
    }
}

struct Question: View{
    let title: String
    let subtitle: String
    let number: QuestionNumber
    var body: some View{
        HStack(alignment: .top, spacing: 11){
            Image(systemName: number.numberIcon)
            VStack(alignment: .leading, spacing: 6){
                Text(title)
                    .font(.PretendardBold16)
                    .foregroundColor(.gray525252)
                Text(subtitle)
                    .font(.PretendardSemiBold14)
                    .foregroundColor(.gray525252)
            }
            Spacer()
        }.padding(.horizontal,24)
    }
}
