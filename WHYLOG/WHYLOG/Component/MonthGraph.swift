//
//  MonthGraph.swift
//  WHYLOG
//
//  Created by 원서우 on 12/19/25.
//

import Foundation
import SwiftUI

struct MonthGraph: View {
    // 현재 선택된 월을 부모 뷰와 공유하기 위해 Binding 사용
    @Binding var selectedMonth: String
    @State private var currentYear: Int = 2025 // 연도 변경 기능을 위해 State로 선언
    
    // 3열 그리드 설정
    let columns = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            yearHeader
            
            // 1월부터 12월까지 반복 생성
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(1...12, id: \.self) { month in
                    monthItem(month: month)
                }
            }
        }
        .padding(15)
        .frame(width: 169) // 그리드가 들어갈 수 있도록 폭을 조금 넓혔습니다.
        .background(
            RoundedRectangle(cornerRadius: 17.7)
                .fill(Color.white)
                .stroke(Color.gray949494, lineWidth: 1.8)
        )
    }
    
    // 연도 선택 부분
    var yearHeader: some View {
        HStack(spacing: 15) {
            Button(action: { currentYear -= 1 }) {
                Image("arrow_back")
                    .resizable()
                    .frame(width: 11.5248, height: 11.5248)
            }
            Text("\(String(currentYear))")
                .font(.headline)
            Button(action: { currentYear += 1 }) {
                Image("arrow_front")
                    .resizable()
                    .frame(width: 11.5248, height: 11.5248)
            }
        }
        .foregroundStyle(Color.gray525252)
    }

    // 개별 월 아이템 (함수 형태로 변경하여 파라미터 전달 가능하게 함)
    func monthItem(month: Int) -> some View {
        let monthText = "\(month)월"
        let isSelected = selectedMonth.contains(monthText)
        
        return Button(action: {
            selectedMonth = "\(currentYear). \(monthText)"
        }) {
            Text(monthText)
                .font(.PretendardMedium10)
                .foregroundStyle(isSelected ? Color.accentCoral : Color.gray949494)
                .frame(width: 40.7, height: 25.7) // 디자인에 맞춰 조절
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(isSelected ? Color.intermediateCoral : Color.white)
                        .stroke(isSelected ? Color.accentCoral : Color.gray949494, lineWidth: 0.9)
                )
        }
    }
}
