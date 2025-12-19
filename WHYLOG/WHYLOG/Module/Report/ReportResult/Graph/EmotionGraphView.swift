//
//  EmotionGraphView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import SwiftUI

struct EmotionGraphView: View {
    let items: [EmotionGraphItem]

    private let barHeight: CGFloat = 100
    private let barWidth: CGFloat = 15

    var body: some View {
        HStack(spacing: 34) {
            ForEach(items) { item in
                VStack(spacing: 7) {
                    ZStack(alignment: .bottom) {

                        // 회색 전체 바 (둥글)
                        Capsule()
                            .fill(.grayD9D9D9)
                            .frame(width: barWidth, height: barHeight)

                        // 파란 채움 (둥글)
                        if item.ratio > 0 {
                            Capsule()
                                .fill(.accentBlue)
                                .frame(
                                    width: barWidth,
                                    height: max(barWidth, barHeight * item.ratio)
                                )
                        }

                    }

                    Text(item.type.rawValue)
                        .font(.PretendardMedium10)
                        .foregroundStyle(.gray525252)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 28)
        .background(Color.white)
        .cornerRadius(22)
    }
}
