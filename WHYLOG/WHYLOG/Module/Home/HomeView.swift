//
//  HomeView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - API 데이터 상태
    @State private var records: [RecordDTO] = []
    @State private var isLoading: Bool = false
    
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var selectedYear: Int = 2025
    @State private var selectedMonth: MonthListState = .Mar
    @State private var selectedEmotionType: SelectionType? = nil
    @State private var monthPage: Int = 0
    
    // MARK: - 필터링 로직
    private var filteredLogs: [RecordDTO] {
        records.filter { log in
            log.occurDate.contains(selectedMonth.MonthNumber)
        }
    }
    
    // MARK: - 데이터 로드 함수 (userId: 5 적용)
    func loadRecords() async {
        self.isLoading = true
        do {
            let fetched = try await RecordService.shared.fetchRecords(
                userId: 5,
                year: selectedYear,
                month: Int(selectedMonth.MonthNumber) ?? 1
            )
            self.records = fetched
        } catch {
            print("❌ 기록 로드 실패: \(error)")
        }
        self.isLoading = false
    }

    var body: some View {
        ZStack {
            Color.baseCoral.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                yearSelector
                monthSelector
                swipeButtons
                
                if let type = selectedEmotionType {
                    emotionChipGroup(for: type)
                        .padding(.top, 10)
                }
                
                Spacer(minLength: 20)
                recordScrollView
            }
            .padding(.horizontal, 20)
            
            VStack {
                Spacer()
                addButton
            }
        }
        .navigationBarBackButtonHidden(true)
        .task { await loadRecords() }
        .onChange(of: selectedMonth) { _, _ in Task { await loadRecords() } }
        .onChange(of: selectedYear) { _, _ in Task { await loadRecords() } }
    }
}

// MARK: - 하위 뷰 구성
extension HomeView {
    private var headerView: some View {
        HStack {
            Image("WHYLOGLogo").resizable().frame(width: 97, height: 25)
            EmotionDropdown(selectedType: $selectedEmotionType)
            Spacer()
            NavigationLink(destination: EmptyView()) {
                Image(systemName: "text.document").resizable().scaledToFit().frame(width: 24, height: 24).foregroundColor(.gray525252)
            }
            NavigationLink(destination: MyProfileView(viewModel: profileViewModel)) {
                Image("user").resizable().scaledToFit().frame(width: 24, height: 24).foregroundColor(.gray525252)
            }
        }.padding(.top, 10)
    }
    
    private var yearSelector: some View {
        HStack(spacing: 20) {
            Button(action: { selectedYear -= 1 }) { Image("arrow_back").foregroundColor(.gray525252) }
            Text("\(String(selectedYear))").font(.PretendardBold20)
            Button(action: { selectedYear += 1 }) { Image("arrow_front").foregroundColor(.gray525252) }
        }.padding(.vertical, 20)
    }
    
    private var monthSelector: some View {
        let allMonths = MonthListState.allCases
        let displayMonths = monthPage == 0 ? Array(allMonths[0...5]) : Array(allMonths[6...11])
        return HStack(spacing: 15) {
            ForEach(displayMonths, id: \.self) { month in
                MonthButton(state: month, isOn: selectedMonth == month) {
                    withAnimation(.spring()) { selectedMonth = month }
                }
            }
        }
    }
    
    private var swipeButtons: some View {
        HStack(spacing: 10) {
            Button(action: { withAnimation { monthPage = 0 } }) { Image("swipe1").opacity(monthPage == 0 ? 1.0 : 0.3) }
            Button(action: { withAnimation { monthPage = 1 } }) { Image("swipe2").opacity(monthPage == 1 ? 1.0 : 0.3) }
        }.padding(.top, 20)
    }
    
    private func emotionChipGroup(for type: SelectionType) -> some View {
        HStack(spacing: 8) {
            let chips = ["회피", "두려움", "불안"]
            ForEach(chips, id: \.self) { text in ChipButton(text: text, state: .constant(.completed)) }
            Spacer()
        }
    }
    
    private var recordScrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                if filteredLogs.isEmpty {
                    Text("\(selectedMonth.MonthNumber)월의 기록이 없습니다.").foregroundColor(.gray).padding(.top, 50)
                } else {
                    ForEach(filteredLogs) { log in
                        NavigationLink(destination: DetailedRecordView(record: log)) {
                            RecordCard(record: log)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }.padding(.bottom, 100)
        }
    }
    
    private var addButton: some View {
        NavigationLink {
            CreateRecordView { Task { await loadRecords() } }
        } label: { AddButtonUI() }.padding(.bottom, 28)
    }
}

#Preview {
    HomeView()
}
