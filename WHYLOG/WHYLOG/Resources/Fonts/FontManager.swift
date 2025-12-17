//
//  FontManager.swift
//  WHYLOG
//
//  Created by 김종수 on 12/15/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    //Bold
    static var PretendardBold20: Font {
        return .pretend(type: .bold, size: 20)
    }
    static var PretendardBold16: Font {
        return .pretend(type: .bold, size: 16)
    }
    //SemiBold
    static var PretendardSemiBold16: Font {
        return .pretend(type: .semibold, size: 16)
    }
    static var PretendardSemiBold14: Font {
        return .pretend(type: .semibold, size: 14)
    }
    //Medium
    static var PretendardMedium12: Font {
        return .pretend(type: .medium, size: 12)
    }
    static var PretendardMedium10: Font {
        return .pretend(type: .medium, size: 10)
    }

}

