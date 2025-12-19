//
//  CreateRecordView.swift
//  WHYLOG
//
//  Created by 원서우 on 12/18/25.
//

import Foundation
import SwiftUI

struct CreateRecordView: View {
    @StateObject private var viewModel = CreateRecordViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.baseCoral
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 24) {
                    navi
                    top
                    middle
                    bottom
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
    
    // MARK: - top
    var top: some View {
        VStack(alignment: .leading, spacing: 18) {
            title
            monthselect
        }
    }
    
    var navi: some View {
        HStack {
            Button {
            } label: {
                Image("arrow_back")
                    .resizable()
                    .foregroundStyle(.gray525252)
                    .frame(width:10.41, height: 17.71)
            }
            Spacer()
            Text("한 줄 기록")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
            Spacer()
            

        }
        .padding(.top, 5)
        
    }
    
    var title: some View {
        VStack {
            Text("2025년 한 해동안\n한 일들을 회고해보아요!")
                .font(.PretendardSemiBold16)
        }
    }
    
    var monthselect: some View {
        VStack(spacing: 8) {
                MonthSelectButton(
                    title: viewModel.selectedMonth,
                    isSelected: viewModel.isDateSelected,
                    action: {
                        withAnimation(.spring()) {
                            viewModel.showMonthGraph.toggle()
                        }
                    }
                )
                
                if viewModel.showMonthGraph {
                    MonthGraph(selectedMonth: $viewModel.selectedMonth)
                        .onChange(of: viewModel.selectedMonth) { oldValue, newValue in
                            withAnimation {
                                viewModel.showMonthGraph = false
                            }
                        }
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
    }
    
    // MARK: - middle
    var middle: some View {
        VStack(alignment: .leading, spacing: 20) {
                WriteCard(
                    title: "어떤 일을 했었나요?",
                    text: $viewModel.whatHappened,
                    height: 60
                )
            
                WriteCard(
                    title: "그렇게 행동한 이유를 입력해주세요.",
                    text: $viewModel.whyAction,
                    height: 224
                )
            }
    }
    
    // MARK: - bottom
    var bottom: some View {
        VStack(spacing: 62) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 5) {
                    ForEach($viewModel.emotions) { $item in
                        ChipButton(text: item.text, state: $item.state)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            OnboardingNavigationBar(title: "완료",action: {},destination: InitializeProfileView()) //도착 수정  -> 홈 뷰
        }
    }
}

#Preview {
    CreateRecordView()
}


//let savedEmotions = ["두려움", "회피"]

//HStack {
//    ForEach (savedEmotions, id: \.self) { text in
//    ChipButton(text: text, state:  .constant(.completed))
//    }
//}
