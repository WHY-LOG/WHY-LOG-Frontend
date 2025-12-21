//
//  HomeView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var selectedYear: Int = 2025
    @State private var selectedMonth: MonthListState = .Mar
    
    // 추가 3 관련: 선택된 유형에 따른 감정 상태
    @State private var selectedEmotionType: SelectionType? = nil // "유형" 선택 상태
    
    // 추가 2 관련: 6개씩 끊어서 보여주기 위한 페이지 상태 (0: Jan~Jun, 1: Jul~Dec)
    @State private var monthPage: Int = 0
    
    // 추가 1 관련: 필터링된 로그 계산
    private var filteredLogs: [RecordDTO] { // [RecordCardModel]에서 변경
        mockLogs.filter { log in
            log.occurDate == selectedMonth.MonthNumber
        }
    }

    var body: some View {
        ZStack {
            Color.baseCoral
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 상단 헤더
                headerView
                
                // 연도 선택
                yearSelector
                
                // 추가 2: 월 선택 영역 (6개 노출 및 버튼 이동)
                monthSelector
                
                // 추가 2: Swipe 버튼 (페이지 전환)
                swipeButtons
                
                // 추가 3: 유형 클릭 시 나타나는 감정 칩 영역
                if let type = selectedEmotionType {
                    emotionChipGroup(for: type)
                        .padding(.top, 10)
                }
                
                Spacer(minLength: 20)
                
                // 추가 1: 필터링된 기록 리스트
                recordScrollView
            }
            .padding(.horizontal, 20)
            
            // 플로팅 버튼
            VStack {
                Spacer()
                addButton
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - 하위 뷰 구성
extension HomeView {
    
    private var headerView: some View {
        HStack {
            Image("WHYLOGLogo")
                .resizable()
                .frame(width: 97, height: 25)
            
            // 추가 3: 선택 시 상태 업데이트를 위해 바인딩 전달 (컴포넌트 수정 필요)
            EmotionDropdown(selectedType: $selectedEmotionType)
            
            Spacer()
            
            NavigationLink(destination: EmptyView()) { // ReportListView()
                Image(systemName: "text.document")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray525252)
            }
            
            NavigationLink(destination: MyProfileView(viewModel: profileViewModel)) {
                Image("user")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray525252)
            }
        }
        .padding(.top, 10)
    }
    
    private var yearSelector: some View {
        HStack(spacing: 20) {
            Button(action: { selectedYear -= 1 }) {
                Image("arrow_back").foregroundColor(.gray525252)
            }
            Text("\(String(selectedYear))")
                .font(.PretendardBold20)
            Button(action: { selectedYear += 1 }) {
                Image("arrow_front").foregroundColor(.gray525252)
            }
        }
        .padding(.vertical, 20)
    }
    
    private var monthSelector: some View {
        let allMonths = MonthListState.allCases
        // 페이지에 따라 0~5(Jan~Jun) 또는 6~11(Jul~Dec) 슬라이싱
        let displayMonths = monthPage == 0 ? Array(allMonths[0...5]) : Array(allMonths[6...11])
        
        return HStack(spacing: 15) {
            ForEach(displayMonths, id: \.self) { month in
                MonthButton(state: month, isOn: selectedMonth == month) {
                    withAnimation(.spring()) {
                        selectedMonth = month
                        // 여기서 실제 API fetch 함수를 호출할 수 있습니다.
                    }
                }
            }
        }
    }
    
    private var swipeButtons: some View {
        HStack(spacing: 10) {
            Button(action: { withAnimation { monthPage = 0 } }) {
                Image("swipe1")
                    .opacity(monthPage == 0 ? 1.0 : 0.3)
            }
            Button(action: { withAnimation { monthPage = 1 } }) {
                Image("swipe2")
                    .opacity(monthPage == 1 ? 1.0 : 0.3)
            }
        }
        .padding(.top,20)
    }
    
    // 추가 3: 감정 칩 뷰
    private func emotionChipGroup(for type: SelectionType) -> some View {
        HStack(spacing: 8) {
            // 예시 데이터: 실제로는 유형별 감정 배열을 매핑해야함.
            let chips = ["회피", "두려움", "불안"]
            ForEach(chips, id: \.self) { text in
                ChipButton(text: text, state: .constant(.completed))
            }
            Spacer()
        }
    }
    
    private var recordScrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                if filteredLogs.isEmpty {
                    Text("\(selectedMonth.MonthNumber)월의 기록이 없습니다.")
                        .foregroundColor(.gray)
                        .padding(.top, 50)
                } else {
                    // HomeView.swift 내의 ForEach 부분
                    ForEach(filteredLogs) { log in
                        NavigationLink(destination: DetailedRecordView(record: log)) {
                            RecordCard(record: log)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }                }
            }
            .padding(.bottom, 100)
        }
    }
}

private var addButton: some View {
            NavigationLink {
                CreateRecordView()
            } label: {
                AddButtonUI()
            }.padding(.bottom, 28)
        }


#Preview {
    HomeView()
}
