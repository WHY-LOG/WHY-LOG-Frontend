//
//  SecondServiceGuideView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

struct SecondServiceGuideView: View {
    var body: some View {
            ZStack{
                Color.baseCoral
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Image("swipe2")
                        Image("swipe1")
                    }
                    HStack(){
                        Text("WHY를 떠올릴 때\n이런 질문을 던져보세요")
                            .font(.PretendardBold20)
                            .foregroundColor(.gray525252)
                        Spacer()
                    }.padding(.top,53)
                        .padding(.bottom,28)
                    VStack(alignment: .leading, spacing: 18){
                        Question(title: "감정 패턴", subtitle: "올해 당신의 선택을\n가장 자주 이끌었던 감정은 무엇이었나요?", number: .one)
                        Question(title: "비교 기준", subtitle: "올해 누구와, 어떤 기준으로\n자신을 가장 많이 비교했나요?", number: .two)
                        Question(title: "회피 경향", subtitle: "올해 반복해서 피하려 했던\n 상황이나 결정이 있었나요?", number: .three)
                        Question(title: "기대와 목적", subtitle: "올해 선택할 때 가장 자주 기대했던 결과는\n 무엇이었나요?", number: .four)
                        Question(title: "당연하게 여긴 기준", subtitle: "올해 당신에게 ‘당연하다’고 여겨졌던 판단 기\n준은 무엇이었나요?", number: .five)
                    }.frame(maxWidth:.infinity)
                        .padding(.vertical,32)
                        .background(Color.white)
                        .cornerRadius(18)
                    .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.intermediateCoral, lineWidth: 2)
                        )
                    
                    Spacer()
                    PrimaryButton(title: "다음", action: {}, destination: ContentView())
                    
                }.padding(.horizontal,20)
            }
        }
    }

#Preview {
    SecondServiceGuideView()
}
