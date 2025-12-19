//
//  RecordCard.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

struct RecordCard: View {
    let recordCardModel: RecordCardModel
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            HStack(){
                Text(recordCardModel.month)
                    .font(.PretendardBold20)
                    .foregroundColor(.gray525252)
                Spacer()
                HStack {
                    ForEach (recordCardModel.emotion, id: \.self) { text in
                    ChipButton(text: text, state:  .constant(.completed))
                    }
                }
                
            }
            Text(recordCardModel.title)
                .font(.PretendardBold20)
                .foregroundColor(.gray525252)
            
            Text(recordCardModel.content)
                .font(.PretendardMedium12)
                .foregroundColor(.gray525252)
        }.padding(33)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 4, y: 4)
        
        
    }
    
}

