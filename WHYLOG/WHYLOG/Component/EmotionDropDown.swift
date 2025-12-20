//
//  EmotionDropDown.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

struct EmotionDropdown: View {
    @State private var isExpanded: Bool = false
    @Binding var selectedType: SelectionType?
    
    var body: some View {
        // 1. 기준이 되는 버튼
        Button(action: {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                isExpanded.toggle()
            }
        }) {
            HStack {
                Text("유형")
                Image(systemName: "triangle.fill")
                    .resizable()
                    .frame(width: 10, height: 5)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
            }
            .font(.PretendardMedium12)
            .foregroundColor(.gray949494)
            .padding(.horizontal, 11)
            .padding(.vertical,4.5)
            .background(
                Capsule()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .background(Color.white.clipShape(Capsule()))
            )
        }
        // 2. 버튼의 위치를 기준으로 오버레이를 씌움
        .overlay(alignment: .top) {
            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(SelectionType.allCases, id: \.self) { type in
                        dropdownRow(type)
                    }
                }
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 10)
                .frame(width: 100) // 버튼보다 조금 더 넓게 설정
                // 버튼 높이 + 간격만큼 아래로 밀어서 표시
                .offset(y: 30)
            }
        }
        // 다른 뷰들보다 항상 위에 보이도록 설정
        .zIndex(10)
    }
    
    // 리스트의 각 행 (Row)
    @ViewBuilder
    private func dropdownRow(_ type: SelectionType) -> some View {
        Button(action: {
            selectedType = type
            withAnimation { isExpanded = false }
        }) {
            VStack(spacing: 0) {
                Text(type.rawValue)
                    .font(.PretendardMedium12)
                    .foregroundColor(selectedType == type ? .black : .gray949494)
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                    .background(selectedType == type ? Color.grayD9D9D9 : Color.clear)
                
                if type != SelectionType.allCases.last {
                    Divider().padding(.horizontal, 20)
                }
            }
        }
    }
}
