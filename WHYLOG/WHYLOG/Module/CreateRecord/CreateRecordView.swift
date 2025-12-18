//
//  CreateRecordView.swift
//  WHYLOG
//
//  Created by 원서우 on 12/18/25.
//

import Foundation
import SwiftUI

struct CreateRecordView: View {
    let savedEmotions = ["두려움", "회피"]
    
    @StateObject private var viewModel = CreateRecordViewModel()
    
    var body: some View {
//        top
    
        middle  //let savedEmotions랑 middle부분 보시면서 chip컴포넌트 사용하시면 됩니다!
        
        Spacer()
        bottom
    }
    
    var middle: some View {
        HStack {
            ForEach (savedEmotions, id: \.self) { text in
            ChipButton(text: text, state:  .constant(.completed))
            }
        }
    }
    
    var bottom: some View {
        VStack{
            ScrollView(.horizontal) {
                LazyHStack(spacing: 5) {
                    ForEach($viewModel.emotions) { $item in
                        ChipButton(text: item.text, state: $item.state)
                    }
                }
            }
            .frame(height: 318)
            .scrollIndicators(.hidden)
            .padding()
            
            
        }
    }
}

#Preview {
    CreateRecordView()
}
