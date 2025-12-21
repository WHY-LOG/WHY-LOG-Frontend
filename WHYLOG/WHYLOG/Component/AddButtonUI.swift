//
//  AddButton.swift
//  WHYLOG
//
//  Created by 김진서 on 12/17/25.
//

import SwiftUI

struct AddButtonUI: View {
    var body: some View {
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
