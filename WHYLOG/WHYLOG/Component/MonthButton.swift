//
//  MonthButton.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

struct MonthButton: View {
    let state: MonthListState
    let isOn: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action){
            VStack(spacing: 19) {
                            Text(state.MonthCap)
                                .font(.PretendardMedium20)
                            Text(state.MonthNumber)
                                .font(.PretendardMedium20)
                        }
                        .foregroundColor(isOn ? .white : .gray525252)
                        .frame(width: 46,height: 97)
                        
                        .background(
                            isOn ? Color.accentCoral : Color.clear // 선택 시 분홍색 배경
                        )
                        .cornerRadius(20)
                    }
                }
            }
//            VStack{
//                Text(monthListState.MonthCap)
//                    .font(.PretendardMedium20)
//                    .foregroundColor(.gray525252)
//                Text(monthListState.MonthNumber)
//                    .font(.PretendardMedium20)
//                    .foregroundColor(.gray525252)

