//
//  WriteCard.swift
//  WHYLOG
//
//  Created by 원서우 on 12/19/25.
//

import Foundation
import SwiftUI

struct WriteCard: View {
    let title: String
        @Binding var text: String
        let height: CGFloat

        var body: some View {
            ZStack(alignment: .topLeading) {
                // 배경 상자
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                
                // 힌트 텍스트 (Placeholder)
                if text.isEmpty {
                    Text(title)
                        .font(.PretendardMedium12) // 프로젝트 폰트에 맞게 수정
                        .foregroundColor(.gray949494)
                        .padding(.top, 25)
                        .padding(.leading, 20)
                }

                // 입력창
                TextEditor(text: $text)
                    .font(.PretendardMedium12)
                    .scrollContentBackground(.hidden) // 배경색 커스텀을 위해 필수
                    .padding(.top, 17)
                    .padding(.horizontal, 15)
            }
            .frame(height: height)
        }
}
