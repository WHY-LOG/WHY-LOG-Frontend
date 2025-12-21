//
//  ReportLoadingView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.
//

import SwiftUI

struct ReportLoadingView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let reportService = ReportService()
    
    @State private var activeDotIndex: Int = 0
    private let dotCount = 3


    @State private var goToResult = false
    @State private var loadingTask: Task<Void, Never>?

    let userId: Int
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
            ReportResultView(year: year, mode: .create)
        }
        .onAppear {
            startLoading()
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Loading Logic
    private func startLoading() {
        loadingTask = Task {
            do {
                // 리포트 생성 API
                _ = try await reportService.createReport(
                    userId: userId,
                    year: year
                )

                // UX용 로딩 딜레이
                try await Task.sleep(nanoseconds: 1_000_000_000)

                if Task.isCancelled { return }

                // 결과 화면 이동
                await MainActor.run {
                    goToResult = true
                }

            } catch {
                print("❌ 리포트 생성 실패:", error)
                dismiss() // TODO: 에러 화면 구현 고민
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
            Text(loadingText)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)

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
    
    
    // MARK: - Atrributed Text
    private var loadingText: AttributedString {
        var text = AttributedString("\(year)년 판단 리포트를\n만들고 있어요")
        text.font = .PretendardBold20
        text.foregroundColor = .gray525252
            

        if let range = text.range(of: "\(year)") {
            text[range].foregroundColor = .accentCoral
        }

        return text
    }
}



#Preview {
    NavigationStack {
        ReportLoadingView(
            userId: 4,   // 임시 userId
            year: 2025
        )
    }
}
