//
//  PrimaryTextField.swift
//  WHYLOG
//
//  Created by 김종수 on 12/18/25.
//

import Foundation
import SwiftUI

struct PrimaryTextField: View {
    let placeholder: String
    @Binding var text: String
    var isDisabled: Bool = false
    
    var body: some View {
        TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray949494)) // placeholder 색상 지정
            .font(.PretendardMedium12)
            .padding(.vertical, 18)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(18)

    }
}
