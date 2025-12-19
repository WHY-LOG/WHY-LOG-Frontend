//
//  ReportResultView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/19/25.
//

import SwiftUI

struct ReportResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    let savedEmotions = ["두려움", "회피"]
    @State private var writingText: String = ""

    
    var body: some View {
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
        .padding(.bottom, 21)
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
        }
    }
    
    // MARK: - Top Content
    private var topContent: some View {
        VStack (alignment: .leading){
            HStack {
                Text("2025 판단 기준 리포트")
                    .font(.PretendardBold16)
                    .foregroundStyle(.gray525252)
                Spacer()
                Text("수정 삭제")
                
            }
            Text("ㅇㅇㅇ님은 회피주의자 유형이에요.")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
                .padding(.bottom, 17)
                .padding(.top, 31)
        }
    }
    
    // MARK: - Graph Box
    private var graphBox: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 164.9)
                .background(.white)
                .cornerRadius(17.7)
                .padding(.bottom, 14.8)
        }
    }
    
    // MARK: - Middle Content
    private var middleContent: some View {
        VStack (alignment: .leading) {
            
            Text("2025년 당신의 판단은 \n회피(52%)와 두려움(19%)에서 시작되었습니다.")
                .font(.PretendardMedium12)
                .foregroundStyle(.gray525252)
            
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 0.88652)
                .background(.grayC5C5C5)
                .padding(.top, 18)
                .padding(.bottom, 21)
            
            Text("가장 반복된 판단 동기")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
                .padding(.bottom, 11.6)
            // Selected Chip
            HStack {
                ForEach (savedEmotions, id: \.self) { text in
                    ChipButton(text: text, state:  .constant(.completed))
                }
            }
            
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 0.88652)
                .background(.grayC5C5C5)
                .padding(.top, 35)
                .padding(.bottom, 21)
            
            Text("당신의 선택을 가장 많이 이끈 기준")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
                .padding(.bottom, 8.48)
            
            Text("2025년 당신의 판단은 \n회피(52%)와 두려움(19%)에서 시작되었습니다.")
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
    ReportResultView()
}
