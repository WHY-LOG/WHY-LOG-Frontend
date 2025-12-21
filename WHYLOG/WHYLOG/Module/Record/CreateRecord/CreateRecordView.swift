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
    @Environment(\.dismiss) var dismiss
    
    // MARK: - 인자 추가
    var editingRecord: RecordDTO? // 상세 뷰에서 수정 시 넘겨주는 데이터
    var onComplete: (() -> Void)? // 생성/수정 완료 후 실행할 콜백
    
    // 초기화 함수 추가
    init(editingRecord: RecordDTO? = nil, onComplete: (() -> Void)? = nil) {
        self.editingRecord = editingRecord
        self.onComplete = onComplete
    }

    var body: some View {
        ZStack {
            Color.baseCoral.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 24) {
                navi
                top
                middle
                bottom
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // 수정 모드일 경우 ViewModel 설정
            if let record = editingRecord {
                viewModel.setupEditMode(with: record)
            }
        }
        .onChange(of: viewModel.isSuccess) { _, newValue in
            if newValue {
                onComplete?() // 홈 화면 새로고침 실행
                dismiss()     // 현재 창 닫기
            }
        }
    }
    
    // MARK: - 하위 뷰 구성
    var navi: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image("arrow_back")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.gray525252)
            }
            Spacer()
            Text(viewModel.isEditMode ? "기록 수정" : "한 줄 기록")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
            Spacer()
            Color.clear.frame(width: 20)
        }
        .padding(.top, 5)
    }
    
    var top: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(viewModel.isEditMode ? "기록을 수정하여\n더 나은 회고를 남겨보아요." : "2025년 한 해동안\n한 일들을 회고해보아요!")
                .font(.PretendardSemiBold16)
            
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
                    .onChange(of: viewModel.selectedMonth) { _, _ in
                        withAnimation { viewModel.showMonthGraph = false }
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
    
    var middle: some View {
        VStack(alignment: .leading, spacing: 20) {
            WriteCard(title: "어떤 일을 했었나요?", text: $viewModel.whatHappened, height: 60)
            WriteCard(title: "그렇게 행동한 이유를 입력해주세요.", text: $viewModel.whyAction, height: 224)
        }
    }
    
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
            
            Button(action: {
                viewModel.uploadRecord()
            }) {
                Text("완료")
                    .foregroundColor(.white)
                    .font(.PretendardBold16)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
            }
            .background(Color.accentCoral)
            .cornerRadius(12)
            .disabled(viewModel.isLoading)
            .opacity(viewModel.isLoading ? 0.6 : 1.0)
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
