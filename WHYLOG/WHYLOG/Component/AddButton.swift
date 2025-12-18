//
//  AddButton.swift
//  WHYLOG
//
//  Created by 김진서 on 12/17/25.
//

import SwiftUI

// 생성 버튼 컴포넌트
struct AddButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.accentBlue)
                    .frame(width: 64, height: 64)

                Image("icon_add")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
            }
        }
    }
}
