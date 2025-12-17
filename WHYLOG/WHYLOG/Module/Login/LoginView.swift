//
//  LoginView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/17/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color.baseCoral
                    .ignoresSafeArea()
                VStack(alignment: .center){
                    Image("WHYLOGLogo")
                        .resizable()
                        .frame(width: 215,height: 55)
                        .padding(.bottom)
                    Text("결과가 아닌 이유로 한 해를 돌아보는 회고 서비스")
                        .font(.PretendardMedium12)
                        .foregroundStyle(Color.gray525252)
                        .padding(.bottom,70)
                    OnboardingNavigationBar(title: "시작하기",action: {},destination: InitializeProfileView())
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
