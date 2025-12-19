//
//  ReportListView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.


import SwiftUI

struct ReportListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var state: ReportListState = .empty
    @StateObject private var viewModel = ReportListViewModel()
    
    @EnvironmentObject var reportStore: ReportStore
    
    private let year = 2025
    
    var body: some View {
        ZStack {
            // Background
            Color(.baseCoral)
                .ignoresSafeArea()
            
            VStack {
                navigationBar
                contentView
                addButton
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.fetchReports()
        }
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
    
    // MARK: - Content View
//    private var contentView: some View {
//        Group {
//            switch state {
//            case .empty:
//                emptyStateView
//                
//            case .loaded(let years):
//                reportListView(years)
//                
//            case .networkError:
//                networkErrorView
//            }
//        }
//    }
    private var contentView: some View {
            Group {
                if reportStore.hasReport(year: year) {
                    reportListView([year])
                } else {
                    emptyStateView
                }
            }
        }
    
    // reportListView
//    private func reportListView(_ years: [Int]) -> some View {
//        // 리포트 카드
//        HStack {
//            ForEach(years, id: \.self) { year in
//                Spacer()
//                YearReportCard(year: year, selectedYear: year) {
//                    print("\(year) 선택")
//                }
//                Spacer()
//            }
//        }
//        .padding(.top, 50)
//    }
    private func reportListView(_ years: [Int]) -> some View {
        HStack {
            ForEach(years, id: \.self) { year in
                NavigationLink {
                    ReportResultView(year: year)
                } label: {
                    YearReportCard(year: year, selectedYear: year) {}
                }
            }
        }
    }

    
    // emptyStateView
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Image("sentiment_dissatisfied")
                .resizable()
                .frame(width: 60, height: 60)
                .padding(.bottom, 40)
            Text("아직 생성된 리포트가 없습니다")
                .font(.PretendardBold20)
                .foregroundStyle(.gray525252)
                .padding(.bottom, 16)
            Text("회고를 바탕으로\n나만의 리포트를 만들어보세요")
                .font(.PretendardMedium12)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray525252)
        }
    }
    
    // networkErrorView
    private var networkErrorView: some View {
        VStack {
            Spacer()
            
            Image("wifi_error")
                .padding(.bottom, 52.33)
            
            Text("네트워크 상태를 확인해주세요")
                .font(.PretendardBold20)
                .foregroundStyle(.gray525252)
            Text("서버와의 통신이 운활하지 않아 데이터를 불러올 수 없습니다")
                .font(.PretendardMedium12)
                .foregroundStyle(.gray525252)
                .padding(.bottom, 20)
                .padding(.top, 16)
            
            Button() {
                Task {
                    await viewModel.fetchReports()
                }
            } label: {
                Text("재시도")
                    .foregroundStyle(.white)
                    .font(.PretendardMedium12)
                    .padding(.vertical,11.5)
                    .frame(maxWidth:.infinity)
                    .background(Color.accentCoral)
                    .cornerRadius(8.87)
                    .padding(.horizontal,48)
            }
            
            Spacer()
        }
    }
    
    
    // MARK: - addButton
    private var addButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    ReportCreateConfirmView(year: 2025)
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
