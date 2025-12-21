//
//  DetailedRecordView.swift
//  WHYLOG
//
//  Created by 원서우 on 12/19/25.
//

import Foundation
import SwiftUI

struct DetailedRecordView: View {
    @StateObject private var viewModel = DetailedRecordViewModel()
    @Environment(\.dismiss) var dismiss
    
    // HomeView에서 넘겨받을 데이터
    let record: RecordDTO
    
    @State private var showAlert = false
    @State private var alertType: AlertType = .edit
    @State private var navigateToEdit = false
    @State private var navigateToHome = false
    
    enum AlertType {
        case edit, delete
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.baseCoral
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 24) {
                    navi
                    Spacer()
                    VStack {
                        top
                        middle
                        Spacer()
                        bottom
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                // 화면 전환 처리
                .navigationDestination(isPresented: $navigateToEdit) {
                    // 수정 모드로 진입하기 위해 record 전달
                    CreateRecordView(editingRecord: record) {
                        dismiss() // 수정 완료 후 상세 페이지 닫기
                    }
                }
                
                .navigationDestination(isPresented: $navigateToHome) {
                    HomeView()
                }
                
                // 알럿 노출
                if showAlert {
                    CustomAlert(
                        title: alertType == .edit ? "수정하시겠습니까?" : "삭제하시겠습니까?",
                        message: alertType == .delete ? "삭제 시 해당 내용이 모두 사라집니다." : nil,
                        action: {
                            if alertType == .edit {
                                showAlert = false
                                navigateToEdit = true
                            } else {
                                // 삭제 로직 (userId: 5 적용)
                                Task {
                                    let success = await viewModel.deleteRecord(userId: 5, recordId: record.recordId)
                                    if success {
                                        showAlert = false
                                        dismiss()
                                    }
                                }
                            }
                        },
                        cancelAction: { showAlert = false }
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - 상단 네비게이션
    var navi: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image("arrow_back")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10.41, height: 17.71)
                    .foregroundStyle(.gray525252)
            }
            Spacer()
            Text("상세 기록")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
            Spacer()
            Color.clear.frame(width: 10.41, height: 17.71)
        }
        .padding(.top, 5)
    }

    // MARK: - 상단 타이틀
    var top: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image("WHYLOGLogo")
                    .resizable()
                    .frame(width: 86, height: 22)
                Spacer()
            }
            Text("2025년 한 해 동안\n기록한 회고에요.")
                .font(.PretendardSemiBold16)
        }
    }
    
    // MARK: - 중앙 카드 영역
    var middle: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    // 날짜 표시
                    Text(record.occurDate + " 기록")
                        .font(.PretendardBold20)
                        .foregroundColor(.gray525252)
                    Spacer()
                    // 카테고리 칩
                    HStack {
                        ForEach(record.categoryNames, id: \.self) { text in
                            ChipButton(text: text, state: .constant(.completed))
                        }
                    }
                }
                
                Text(record.title)
                    .font(.PretendardBold20)
                    .foregroundColor(.gray525252)
                
                Text(record.content)
                    .font(.PretendardMedium16)
                    .foregroundColor(.gray525252)
                    .lineSpacing(4)
            }
            .padding(33)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(20)
            
            // 수정/삭제 버튼
            HStack {
                Spacer()
                ActionButtons(
                    onEdit: {
                        alertType = .edit
                        withAnimation { showAlert = true }
                    },
                    onDelete: {
                        alertType = .delete
                        withAnimation { showAlert = true }
                    }
                )
            }
        }
    }
    
    // MARK: - 하단 버튼
    var bottom: some View {
        Button {
            dismiss()
        } label: {
            Text("확인")
                .font(.PretendardBold16)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color.accentCoral)
                .cornerRadius(12)
        }
    }
}

#Preview {
    DetailedRecordView(record: RecordDTO(
        recordId: 1,
        title: "제목",
        content: "내용",
        occurDate: "2025-12-01",
        categories: [CategoryDTO(categoryId: 4, categoryName: "회피")] // 형식 수정
    ))
}
