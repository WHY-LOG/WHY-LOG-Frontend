//
//  ReportList.swift
//  WHYLOG
//
//  Created by 김진서 on 12/17/25.
//

import SwiftUI

struct ReportListView: View {
    var body: some View {
        ZStack {
            Text("리포트 목록")
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddButton {
                        // 생성 화면 이동
                        print("Add button tapped")
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    
                }
            }
        }

    }
}

#Preview {
    ReportListView()
}
