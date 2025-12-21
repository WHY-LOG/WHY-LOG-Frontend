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
    let record: RecordDTO // HomeView에서 넘겨받을 데이터
    
    @State private var showAlert = false
    @State private var alertType: AlertType = .edit
    @State private var navigateToEdit = false
    @State private var navigateToHome = false
    
    enum AlertType {
            case edit, delete
        }
    
    var body: some View {
        NavigationStack{
            ZStack{
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
                
                .navigationDestination(isPresented: $navigateToEdit) {
                    CreateRecordView() // 수정 시 이동할 목적지
                }
                
                .navigationDestination(isPresented: $navigateToHome) {
                    HomeView() // 홈 화면 뷰로 연결
                }
                
                if showAlert {
                    CustomAlert(
                        title: alertType == .edit ? "수정하시겠습니까?" : "삭제하시겠습니까?",
                        message: alertType == .delete ? "삭제 시 해당 내용이 모두 사라집니다." : nil,
                        action: {
                            if alertType == .edit {
                                showAlert = false
                                navigateToEdit = true
                            } else {
                                // 삭제 로직 추가
                                Task {
                                    let success = await viewModel.deleteRecord(userId: 1, recordId: record.recordId) //
                                    if success {
                                        showAlert = false
                                        dismiss() // 또는 navigateToHome = true
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
    }
    
    // MARK: - top
    var top: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack{
                Image("WHYLOGLogo")
                    .resizable()
                    .frame(width: 86, height: 22)
                Spacer()
            }
            Text("2025년 한 해 동안\n회피에 대한 회고에요.")
                .font(.PretendardSemiBold16)
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
            Text("상세 기록")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)
            Spacer()
            

        }
        .padding(.top, 5)
        
    }
    
    
    // MARK: - middle
    var middle: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    // 월 표시
                    Text(record.occurDate + " 기록")
                        .font(.PretendardBold20)
                        .foregroundColor(.gray525252)
                    Spacer()
                    // 선택했던 감정들 칩으로 표시
                    HStack {
                        ForEach(record.categories, id: \.self) { text in
                            ChipButton(text: text, state: .constant(.completed))
                        }
                    }
                }
                
                // 제목
                Text(record.title)
                    .font(.PretendardBold20)
                    .foregroundColor(.gray525252)
                
                // 내용
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
    
    
    // MARK: - bottom
    var bottom: some View {
        VStack() {
            PrimaryButton(title: "완료",action: {},destination: HomeView())
        }
    }
}

#Preview {
        DetailedRecordView(record: RecordDTO(recordId: 1, title: "제목", content: "내용", occurDate: "3", categories: ["회피"]))
    }
