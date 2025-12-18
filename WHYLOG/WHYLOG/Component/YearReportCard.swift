//
//  YearReportCard.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.
//

import SwiftUI

struct YearReportCard: View {
    let year: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {

                // 카드 본체
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(.accentCoral),
                                    Color(.white)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 90, height: 90)
                        .shadow(
                            color: Color.black.opacity(0.25),
                            radius: 3.55,
                            x: 3.55,
                            y: 3.55
                        )

                    Image("file")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 30)
                        .foregroundStyle(.white)
                }

                // 연도 텍스트
                Text("\(String(year))년")
                    .font(.PretendardMedium12)
                    .foregroundColor(.gray525252)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(year)년 리포트 보기")
    }
}
