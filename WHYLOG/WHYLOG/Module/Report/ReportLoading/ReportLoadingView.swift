//
//  ReportLoadingView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.
//

import SwiftUI

struct ReportLoadingView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let selectedYear = 2025
    
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
        }
    
    // MARK: - Navigation Bar
    private var navigationBar: some View {
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
    
    // MARK: - Progress Indicator
    private var progressIndicator: some View {
        HStack(spacing: 8) {
                    Text("로 딩 중") // TODO: - DotProgressView 추가 예정
                }
    }
    
    // MARK: - Middle
    private var loadingMessage: some View {
        VStack {
            VStack {
                Text(attributedString)
                    .font(.PretendardBold20)

                    
                    .padding(.top, 29.37)
                    .padding(.bottom, 29.79)
                    .multilineTextAlignment(.center)
                Text("잠시만 기다려주세요!")
                    .font(.PretendardMedium12)
                    .foregroundStyle(.gray525252)
            }
            
        }
    }
    
    var attributedString: AttributedString {
      var string = AttributedString("\(selectedYear)년 판단 리포트를\n만들고 있어요")
      if let year = string.range(of: "\(selectedYear)") {
        string[year].foregroundColor = .accentCoral
      }
      return string
    }
    
    // MARK: - Bottom
    private var cancelButton: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Text("불러오기 취소")
                    .font(.PretendardMedium12)
                    .foregroundStyle(.gray525252)
            }
            .padding(.bottom, 90)
        }
    }
    
    
    
    
    
    
    
    
    
}

#Preview {
    ReportLoadingView()
}
