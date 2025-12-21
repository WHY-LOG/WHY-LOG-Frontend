//
//  ReportListView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/18/25.
//

import SwiftUI

struct ReportListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ReportListViewModel()
    
    var body: some View {
        ZStack {
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
        .onAppear {
            Task {
                await viewModel.load(userId: 5) // 임시 userId
            }
        }
    }
    // MARK: - Content View
    private var contentView: some View {
        Group {
            if viewModel.reports.isEmpty {
                emptyStateView
            } else {
                reportListView(viewModel.reports)
            }
        }
    }

    
    // MARK: - Report List
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func reportListView(_ reports: [ReportListItemDTO]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(reports, id: \.reportId) { report in
                    NavigationLink {
                        ReportResultView(
                            reportId: report.reportId,
                            year: report.year,
                            mode: .readOnly
                        )
                    } label: {
                        YearReportCard(
                            year: report.year,
                            selectedYear: report.year
                        )
                    }
                }
            }
            .padding(.top, 40)
        }
    }


    
    
    // MARK: - Navigation Bar
    private var navigationBar: some View {
        VStack {
            HStack {
                Image("WHYLOGLogo")
                    .resizable()
                    .frame(width: 86, height: 22)
                Spacer()
            }
            
            HStack {
                NavigationLink { HomeView() } label: {
                    Image("arrow_back")
                        .resizable()
                        .frame(width: 10, height: 18)
                }
                
                Spacer()
                
                Text("판단 기준 리포트 목록")
                    .font(.PretendardBold16)
                
                Spacer()
            }
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Image("sentiment_dissatisfied")
                .resizable()
                .frame(width: 60, height: 60)
            
            Text("아직 생성된 리포트가 없습니다")
                .font(.PretendardBold20)
                .foregroundStyle(.gray525252)
                .padding(.top, 34)
                .padding(.bottom, 16)
            
            Text("회고를 바탕으로\n나만의 리포트를 만들어보세요")
                .font(.PretendardMedium12)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray525252)
            
        }
    }
    
    // MARK: - Add Button
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

