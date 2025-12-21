//
//  ReportResultView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import SwiftUI

enum ReportEntryMode {
    case readOnly      // 리스트에서 들어옴
    case create        // 생성 직후
}

enum AlertType {
    case edit, delete
}

struct ReportResultView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ReportResultViewModel()
    
    let year: Int
    let mode: ReportEntryMode
    
    @State private var isEditing: Bool = false

    @State private var writingText: String = ""
    
    @State private var showAlert = false
    @State private var alertType: AlertType = .edit
    
    
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(.baseCoral)
                    .ignoresSafeArea()
                
                // 메인 뷰
                VStack(spacing: 0) {
                    navigationBar
                    
                    ScrollView {
                        topContent
                        graphBox
                        middleContent
                        writing
                    }
                }
                .padding(.horizontal, 20)
                
                // 완료 버튼 (레이아웃 무관)
                VStack {
                    Spacer()
                    PrimaryButton(
                        title: "완료",
                        action: {
                            Task {
                                try? await viewModel.updateContent(
                                    userId: 1,
                                    content: writingText
                                )
                            }
                        },
                        destination: HomeView()
                    )
                    .padding(.horizontal, 20)
                }
                
                if showAlert {
                    CustomAlert(
                        title: alertType == .edit ? "수정하시겠습니까?" : "삭제하시겠습니까?",
                        message: alertType == .delete ? "삭제 시 해당 내용이 모두 사라집니다." : nil,
                        action: {
                            if alertType == .edit {
                                isEditing = true
                                showAlert = false
                            } else {
                                Task {
                                    do {
                                        try await viewModel.deleteReport(userId: 1)
                                        dismiss()   // ReportListView로 복귀
                                    } catch {
                                        print("❌ 리포트 삭제 실패:", error)
                                    }
                                }
                            }
                        },
                        cancelAction: {
                            showAlert = false
                        }
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
                    
                }
                
            }
        }
        .onAppear {
            Task {
                await viewModel.load(
                    userId: 1,   // TODO: 로그인 연동 후 실제 userId로 교체
                    year: year
                )
                if mode == .create {
                    isEditing = true
                }
            }
        }
        
        .navigationBarBackButtonHidden(true)
    }
        


    
    
    
    // MARK: - Navigation Bar
    private var navigationBar: some View {
        // Navigation Bar
        HStack(alignment: .top) {
            Button {
                dismiss() //TODO: HomeView
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
        .padding(.bottom, 21)
    }
    
    
    // MARK: - Top Content
    private var topContent: some View {
        VStack (alignment: .leading){
            HStack {
                
                Image("WHYLOGLogo")
                    .resizable()
                    .frame(width: 92,height: 22)
                    

                Spacer()
                
                // 수정/삭제 버튼 컴포넌트
                ActionButtons(
                    onEdit: {
                        alertType = .edit
                        withAnimation { showAlert = true }
                    },
                    onDelete: {
                        alertType = .delete
                        withAnimation { showAlert = true }
                    }
                )
                
            }
            .padding(.top, 30)
            Text("\(String(viewModel.year)) 판단 기준 리포트")
                .font(.PretendardBold20)
                .foregroundStyle(.gray525252)
        }
    }
    
    // MARK: - Graph Box
    private var graphBox: some View {
        EmotionGraphView(items: viewModel.graphItems)
            .frame(height: 164.9)
            .padding(.vertical, 40)
    }

    
    // MARK: - Middle Content
    private var middleContent: some View {
        VStack (alignment: .leading) {
            
            summaryView
            
            
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 0.88652)
                .background(.grayC5C5C5)
                .padding(.top, 18)
                .padding(.bottom, 21)
            Spacer()
            
            Text("가장 반복된 판단 동기")
                .font(.PretendardMedium16)
                .foregroundStyle(.gray525252)
                .padding(.bottom, 11.6)
            // Selected Chip
            HStack {
                ForEach(viewModel.dominantTypes, id: \.self) { text in
                    ChipButton(text: text, state: .constant(.completed))
                }
            }
            Spacer()
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 0.88652)
                .background(.grayC5C5C5)
                .padding(.top, 30)
                .padding(.bottom, 21)
            
            
            Text("당신의 선택을 가장 많이 이끈 기준")
                .font(.PretendardMedium16)
                .foregroundStyle(.gray525252)
                .padding(.bottom, 8.48)
            
            Text(viewModel.standardText)
                .font(.PretendardMedium12)
                .foregroundStyle(.gray525252)
        }
    }
    
    // MARK: - 요약 테스트
    private var summaryView: some View {
            VStack(alignment: .leading, spacing: 4) {

                Text("\(String(viewModel.year))년 당신의 판단은")
                    .font(.PretendardMedium12)

                (
                    Text(
                        viewModel.summaryHighlights
                            .map { "\($0.text)(\($0.percent)%)" }
                            .joined(separator: "와 ")
                    )
                    .font(.PretendardSemiBold14)
                )
                Text("에서 시작되었습니다.")
                    .font(.PretendardMedium12)
            }
            .foregroundStyle(.gray525252)
        }
    
    // MARK: - Writing
    private var writing: some View {
        VStack(alignment: .leading) {
            Text("리포트를 기반으로 앞으로의 다짐을 적어보아요.")
                .font(.PretendardMedium16)
                .foregroundStyle(.gray525252)
                .padding(.top, 17)
                .padding(.bottom, 6)
            
            ZStack(alignment: .topLeading) {
                // 배경
                RoundedRectangle(cornerRadius: 17.73)
                    .fill(Color.white)
                    .frame(height:150)
                
                // placeholder
                if writingText.isEmpty {
                    Text("다짐 내용을 적어보세요")
                        .foregroundStyle(.gray949494)
                        .font(.PretendardMedium12)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .allowsHitTesting(false)
                }
                
                // 실제 입력
                TextEditor(text: $writingText)
                    .font(.PretendardMedium12)
                    .foregroundStyle(.gray525252)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                    .disabled(!isEditing)
            }
        }
    }
    
}
    

    
#Preview {
    NavigationStack {
        ReportResultView(year: 2025, mode: .readOnly)
            .environmentObject(ReportStore())
    }
}
