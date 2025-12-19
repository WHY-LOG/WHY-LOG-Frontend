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

            ZStack{
                Color.baseCoral
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Image("swipe1")
                        Image("swipe2")
                    }
                    HStack(){
                        Text("WHY를 이렇게 기록해보세요")
                            .font(.PretendardBold20)
                            .foregroundColor(.gray525252)
                        Spacer()
                    }.padding(.top,53)
                    HStack(){
                        Text("무엇을 했는지 보다,\n왜 그렇게 했는지가 중요합니다")
                            .font(.PretendardMedium16)
                            .foregroundColor(.gray525252)
                        Spacer()
                        
                    }.padding(.top,27)
                    VStack(spacing:24){
                        CheckBox(title:"팀 프로젝트를 힘들어서 맡지 않았다",theme: .blue)
                        CheckBox(title:"팀 프로젝트를 힘들어서 맡지 않았다",theme: .red)
                    }.padding(.top,114)
                    Spacer()
                    PrimaryButton(title: "다음", action: {}, destination: SecondServiceGuideView())
                    
                }.padding(.horizontal,20)
                
            }
        }
    }

#Preview {
    FirstServiceGuideView()
}
