//
//  ReportCreateConfirmView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.
//

import SwiftUI

struct ReportCreateConfirmView: View {
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Background
                Color(.baseCoral)
                    .ignoresSafeArea()
                VStack {
                    Top
                    Spacer()
                    Middle
                    Spacer()
                    Bottom
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    // MARK: - Top
    private var Top: some View {
        // Navigation Bar
        HStack(alignment: .top) {
            Button {
                // 뒤로가기
            } label: {
                Image("arrow_back")
                    .resizable()
                    .foregroundStyle(.gray525252)
                    .frame(width:10.41, height: 17.71)
            }
            Spacer()
            Text("판단 기준 리포트")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
            Spacer()
        }
        .padding(.top, 28.37)
    }
    
    // MARK: - Middle
    private var Middle: some View {
        VStack {
            Text("2025년 판단 리포트를 만드시겠습니까?")
                .font(.PretendardBold20)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray525252)
                .frame(width: 193.26202, alignment: .center)
        }
    }
    
    // MARK: - Bottom
    private var Bottom: some View {
        VStack {
            OnboardingNavigationBar(title: "완료",action: {},destination: InitializeProfileView())
            // TODO: 목적지 변경
        }
    }
}

#Preview {
    ReportCreateConfirmView()
}

