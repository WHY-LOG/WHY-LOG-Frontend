//
//  RecordCard.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

struct RecordCard: View {
    let record: RecordDTO // API용 DTO를 직접 받음
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            HStack(){
                Text(record.occurDate + "월") // DTO 데이터 사용
                    .font(.PretendardBold20)
                    .foregroundColor(.gray525252)
                Spacer()
                HStack {
                    ForEach(record.categories, id: \.self) { text in
                        ChipButton(text: text, state: .constant(.completed))
                    }
                }
            }
            Text(record.title).font(.PretendardBold20)
            Text(record.content).font(.PretendardMedium12)
        }
        .padding(33)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 4, y: 4)
    }
}

