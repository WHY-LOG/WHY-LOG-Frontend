//
//  ReportListView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.


import SwiftUI

struct ReportListView: View {
    @Environment(\.dismiss) private var dismiss

    private let years = [2025, 2024, 2023]

    var body: some View {
        ZStack {
            // Background
            Color(.baseCoral)
                .ignoresSafeArea()
            
            VStack {
                navigationBar
                reportList
                addButton
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Navigation Bar
    private var navigationBar: some View {
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
                    dismiss()
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

    // MARK: - reportList
    private var reportList: some View {
        
        // Year Cards
        HStack {
            ForEach(years, id: \.self) { year in
                Spacer()
                YearReportCard(year: year, selectedYear: year) {
                    print("\(year) 선택")
                }
                Spacer()
            }
        }
        .padding(.top, 50)
    }
    
    // MARK: - addButton
    private var addButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    ReportCreateConfirmView()
                } label: {
                    AddButtonUI()
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
