//
//  ReportCreateConfirmView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.
//

import SwiftUI

struct ReportCreateConfirmView: View {
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
            ZStack {
                // Background
                Color(.baseCoral)
                    .ignoresSafeArea()
                VStack {
                    navigationBar
                    Spacer()
                    confirmText
                    Spacer()
                    confirmButton
                }
                .padding(.horizontal, 20)
            }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Navigation Bar
    private var navigationBar: some View {
        // Navigation Bar
        HStack(alignment: .top) {
            Button {
                dismiss()
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
    
    // MARK: - Confrim Text
    private var confirmText: some View {
        VStack {
            Text("2025년 판단 리포트를 만드시겠습니까?")
                .font(.PretendardBold20)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray525252)
                .frame(width: 193.26202, alignment: .center)
        }
    }
    
    // MARK: - Confirm Button
    private var confirmButton: some View {
        NavigationLink {
                ReportLoadingView()
        } label: {
            Text("완료")
                .foregroundStyle(.white)
                .font(.PretendardBold16)
                .padding(.vertical,18)
                .frame(maxWidth:.infinity)
                .background(Color.accentCoral)
                .cornerRadius(18)
                .padding(.horizontal,18)
        }
    }
}

#Preview {
    ReportCreateConfirmView()
}

