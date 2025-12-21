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

    // MARK: - State
    @State private var activeDotIndex: Int = 0
    private let dotCount = 3

    @State private var loadingTask: Task<Void, Never>?
    @State private var timer: Timer?

    // 생성된 리포트 ID → 이게 세팅되면 결과 화면으로 이동
    @State private var createdReportId: Int? = nil

    @State private var showErrorAlert = false

    let userId: Int
    let year: Int

    // MARK: - Body
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
        // ✅ reportId가 생기면 자동 이동
        .navigationDestination(item: $createdReportId) { reportId in
            ReportResultView(
                reportId: reportId,
                year: year,
                mode: .create
            )
        }
        .onAppear {
            startLoading()
            startDotAnimation()
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
        .navigationBarBackButtonHidden(true)
        .alert("리포트 생성 실패",
               isPresented: $showErrorAlert) {
            Button("확인") {
                dismiss()
            }
        } message: {
            Text("해당 연도에 기록이 없어 리포트를 생성할 수 없어요.")
        }
    }

    // MARK: - Loading Logic
    private func startLoading() {
        loadingTask = Task {
            do {
                let result = try await reportService.createReport(
                    userId: userId,
                    year: year
                )

                // UX용 딜레이
                try await Task.sleep(nanoseconds: 2_000_000_000)

                if Task.isCancelled { return }

                await MainActor.run {
                    createdReportId = result.reportId
                }

            } catch {
                print("❌ 리포트 생성 실패:", error)
                await MainActor.run {
                    showErrorAlert = true
                }
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

    // MARK: - Progress Indicator
    private var progressIndicator: some View {
        HStack(spacing: 10) {
            ForEach(0..<dotCount, id: \.self) { index in
                Circle()
                    .fill(index == activeDotIndex ? Color.accentCoral : Color.grayD9D9D9)
                    .frame(width: 10, height: 10)
                    .animation(.easeInOut(duration: 0.25), value: activeDotIndex)
            }
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
            timer?.invalidate()
            timer = nil
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            activeDotIndex = (activeDotIndex + 1) % dotCount
        }
    }

    // MARK: - Attributed Text
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
            userId: 5,
            year: 2025
        )
    }
}
