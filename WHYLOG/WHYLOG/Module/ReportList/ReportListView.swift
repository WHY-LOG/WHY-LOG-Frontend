//
//  ReportListView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.


import SwiftUI

struct ReportListView: View {


    private let years = [2025, 2024, 2023]

    var body: some View {
        ZStack {
            
            // Background
            Color(.baseCoral)
                .ignoresSafeArea()
            
            VStack {

                Top
                Middle
                Bottom
            }
            .padding(.horizontal, 20)

            
        }
    }
    
    // MARK: - Top
    private var Top: some View {
        VStack {
            
            // Logo
            HStack{
                Image("WHYLOGLogo")
                    .resizable()
                    .frame(width: 86, height: 22)
                Spacer()
            }

            // Navigation Bar
            HStack {
                Button {
                    // 뒤로가기
                } label: {
                    Image("arrow_back")
                        .resizable()
                        .foregroundStyle(.gray525252)
                        .frame(width:10.41, height: 17.71)
                }
                Spacer()
                Text("판단 기준 리포트 목록")
                    .font(.PretendardBold16)
                    .foregroundStyle(.gray525252)
                Spacer()
                

            }
            .padding(.top, 5)
        }
    }

    // MARK: - Middle
    private var Middle: some View {
        
        // Year Cards
        HStack {
            ForEach(years, id: \.self) { year in
                Spacer()
                YearReportCard(year: year) {
                    print("\(year) 선택")
                }
                Spacer()
            }
        }
        .padding(.top, 50)
    }
    
    // Mark: - Bottom
    private var Bottom: some View {
        // MARK: - Floating Add Button
        // TODO: AddButton Component로 변경
        VStack {
            Spacer()
            HStack {
                Spacer()
                AddButton {
                    // 생성 화면 이동
                    print("Add button tapped")
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
                
            }
        }
    }
}






#Preview {
    ReportListView()
}
