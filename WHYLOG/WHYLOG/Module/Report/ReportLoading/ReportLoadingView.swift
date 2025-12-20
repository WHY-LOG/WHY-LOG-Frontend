//
//  ReportLoadingView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.
//

import SwiftUI

struct ReportLoadingView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var activeDotIndex: Int = 0
    private let dotCount = 3


    @State private var goToResult = false
    @State private var loadingTask: Task<Void, Never>?

    let year: Int

    var body: some View {
        ZStack {
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
        .navigationDestination(isPresented: $goToResult) {
            ReportResultView(year: year)
        }
        .onAppear {
            startLoading()
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Loading Logic
    private func startLoading() {
        loadingTask = Task {
            // 나중에 여기서 createReport API 호출
            try? await Task.sleep(nanoseconds: 1_500_000_000)

            if Task.isCancelled { return }

            await MainActor.run {
                goToResult = true
            }
        }
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

    // MARK: - Progress Indicator (점 로딩)
    private var progressIndicator: some View {
        HStack(spacing: 10) {
            ForEach(0..<dotCount, id: \.self) { index in
                Circle()
                    .fill(index == activeDotIndex ? Color.accentCoral : Color.grayD9D9D9)
                    .frame(width: 10, height: 10)
                    .animation(.easeInOut(duration: 0.25), value: activeDotIndex)
            }
        }
        .onAppear {
            startDotAnimation()
        }
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
    
    // MARK: - Dot Animation
    private func startDotAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            activeDotIndex = (activeDotIndex + 1) % dotCount
        }
    }
}



#Preview {
    ReportLoadingView(year: 2025)
}

