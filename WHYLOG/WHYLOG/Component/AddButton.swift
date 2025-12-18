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
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 63.83, height: 63.83)
                .foregroundStyle(.accentBlue)
        }
    }
}
