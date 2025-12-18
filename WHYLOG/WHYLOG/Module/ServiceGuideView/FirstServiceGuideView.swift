//
//  FirstServiceGuideView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/18/25.
//

import Foundation
import SwiftUI

struct FirstServiceGuideView: View{
    var body: some View {
        NavigationStack{
            ZStack{
                Color.baseCoral
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Image("swipe1")
                        Image("swipe2")
                    }
                    HStack(){
                        Text("프로필 정보를 입력해주세요")
                            .font(.PretendardBold20)
                            .foregroundColor(.gray525252)
                        Spacer()
                    }.padding(.top,53)
                    HStack(){
                        Text("무엇을 했는지 보다, 왜 그렇게 했는지가 중요합니다.")
                            .font(.PretendardMedium16)
                            .foregroundColor(.gray525252)
                        Spacer()
                    }.padding(.top,53)
                    Spacer()
                    
                }.padding(.horizontal,20)
                
            }
        }
    }
}

#Preview {
    FirstServiceGuideView()
}
