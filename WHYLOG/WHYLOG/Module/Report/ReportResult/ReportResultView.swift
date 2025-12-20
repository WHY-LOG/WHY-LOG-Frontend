//
//  ReportResultView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import SwiftUI


struct ReportResultView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ReportResultViewModel()

    @State private var writingText: String = ""
    
    
    @State private var showAlert = false
    @State private var alertType: AlertType = .edit
    @State private var navigateToEdit = false
    @State private var navigateToHome = false
    
    enum AlertType {
            case edit, delete
        }
    
    let year: Int
    
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
                    confirmButton
                        .padding(.horizontal, 20)
                }
                
                if showAlert {
                    CustomAlert(
                        title: alertType == .edit ? "수정하시겠습니까?" : "삭제하시겠습니까?",
                        message: alertType == .delete ? "삭제 시 해당 내용이 모두 사라집니다." : nil,
                        action: {
                            if alertType == .edit {
                                navigateToEdit = true
                            } else {
                                navigateToHome = true
                            }
                            showAlert = false
                        },
                        cancelAction: {
                            showAlert = false
                        }
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
                }
                
            }
            .navigationDestination(isPresented: $navigateToEdit) {
                // 수정 화면 (예: 리포트 수정 화면)
                ReportResultView(year: 2025)
            }
            
            .navigationDestination(isPresented: $navigateToHome) {
                CreateRecordView()
            }
        }
        .onAppear {
            viewModel.loadMock(year: year)
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
    
    // MARK: - Confirm Button
    private var confirmButton: some View {
        NavigationLink {
            HomeView() // 이동할 뷰 선택
        } label: {
            Text("완료")
                .foregroundStyle(.white)
                .font(.PretendardBold16)
                .padding(.vertical,18)
                .frame(maxWidth:.infinity)
                .background(Color.accentCoral)
                .cornerRadius(18)
        }
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
            Text("\(viewModel.year) 판단 기준 리포트")
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
            
            Text(viewModel.summaryText)
                .font(.PretendardMedium16)
                .foregroundStyle(.gray525252)
            
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 0.88652)
                .background(.grayC5C5C5)
                .padding(.top, 18)
                .padding(.bottom, 21)
            
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
    
    // MARK: - Writing
    private var writing: some View {
        VStack(alignment: .leading) {
            Text("리포트를 기반으로 앞으로의 다짐을 적어보아요.")
                .font(.PretendardBold16)
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
            }
        }
    }
    
}
    

    
#Preview {
    NavigationStack {
        ReportResultView(year: 2025)
            .environmentObject(ReportStore())
    }
}
