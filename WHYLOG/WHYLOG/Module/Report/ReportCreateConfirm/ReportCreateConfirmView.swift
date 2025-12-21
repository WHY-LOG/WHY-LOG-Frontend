////
////  ReportCreateConfirmView.swift
////  WHYLOG
////
////  Created by 김진서 on 12/18/25.
////
//

import SwiftUI

struct ReportCreateConfirmView: View {
    @Environment(\.dismiss) private var dismiss
    let year: Int

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

                PrimaryButton(
                    title: "완료",
                    action: {},
                    destination: ReportLoadingView(
                        userId: 1,   // TODO: 실제 로그인 유저 ID로 교체
                        year: year
                    )
                )
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Navigation Bar
    private var navigationBar: some View {
        HStack(alignment: .top) {
            Button {
                dismiss()
            } label: {
                Image("arrow_back")
                    .resizable()
                    .foregroundStyle(.gray525252)
                    .frame(width: 10.41, height: 17.71)
            }

            Spacer()

            Text("판단 기준 리포트")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)

            Spacer()
        }
        .padding(.top, 28.37)
    }

    // MARK: - Confirm Text
    private var confirmText: some View {
        VStack {
            Text("\(year)년 판단 리포트를 만드시겠습니까?")
                .font(.PretendardBold20)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray525252)
                .frame(width: 193.26)
        }
    }
}

#Preview {
    NavigationStack {
        ReportCreateConfirmView(year: 2025)
    }
}

