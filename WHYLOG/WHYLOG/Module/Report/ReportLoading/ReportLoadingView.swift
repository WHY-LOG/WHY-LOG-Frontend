//
//  ReportLoadingView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.
//

import SwiftUI

struct ReportLoadingView: View {
    @EnvironmentObject var reportStore: ReportStore
    @State private var goToResult = false
    @State private var loadingTask: Task<Void, Never>?
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
                progressIndicator
                loadingMessage
                Spacer()
                cancelButton
            }
            .padding(.horizontal, 20)
        }
        // 로딩 → 결과 뷰로 이동
        .navigationDestination(isPresented: $goToResult) {
            ReportResultView(year: 2025)
        }
        .onAppear {
            loadingTask = Task {
                try? await Task.sleep(nanoseconds: 1_500_000_000)
                
                if Task.isCancelled { return }
                
                reportStore.createReport(year: year)
                await MainActor.run {
                    goToResult = true   // 화면 이동 트리거
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Navigation Bar
    private var navigationBar: some View {
        HStack {
            Spacer()
            Text("판단 기준 리포트")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
            Spacer()
        }
        .padding(.top, 28)
    }

    // MARK: - Progress Indicator
    private var progressIndicator: some View {
        Text("로 딩 중")
    }

    // MARK: - Loading Message
    private var loadingMessage: some View {
        VStack {
            Text("\(year)년 판단 리포트를\n만들고 있어요")
                .font(.PretendardBold20)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)

            Text("잠시만 기다려주세요!")
                .font(.PretendardMedium12)
                .foregroundStyle(.gray525252)
        }
    }

    // MARK: - Cancel Button
    private var cancelButton: some View {
        Button {
            loadingTask?.cancel()
            dismiss()
        } label: {
            Text("불러오기 취소")
                .font(.PretendardMedium12)
                .foregroundStyle(.gray525252)
        }
        .padding(.bottom, 90)
    }
}

#Preview {
    ReportLoadingView(year: 2025)
}

