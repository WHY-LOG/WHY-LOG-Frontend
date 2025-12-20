//
//  DetailedRecordView.swift
//  WHYLOG
//
//  Created by 원서우 on 12/19/25.
//

import Foundation
import SwiftUI

struct DetailedRecordView: View {
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
                    top
                    middle
                    bottom
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                .navigationDestination(isPresented: $navigateToEdit) {
                    CreateRecordView() // 수정 시 이동할 목적지
                }
                
                .navigationDestination(isPresented: $navigateToHome) {
//                    HomeView() // 홈 화면 뷰로 연결
                }
                
                if showAlert {
                    CustomAlert(
                        title: alertType == .edit ? "수정하시겠습니까?" : "삭제하시겠습니까?",
                        message: alertType == .delete ? "삭제 시 해당 내용이 모두 사라집니다." : nil,
                        action: {
                            if alertType == .edit {
                                // 수정 로직 실행
                                showAlert = false
                                navigateToEdit = true
                            } else {
                                // 삭제 로직 실행
                                showAlert = false
                                navigateToHome = true
                            }
                            showAlert = false
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
        VStack {
            ZStack(alignment: .bottomTrailing) {
                // 기록 카드 공용 컴포넌트
                
                // 수정/삭제 버튼 컴포넌트
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
                .padding(20)
            }
        }
    }
    
    
    // MARK: - bottom
    var bottom: some View {
        VStack() {
            PrimaryButton(title: "완료",action: {},destination: InitializeProfileView()) //도착 수정 -> 홈 뷰
        }
    }
}

#Preview {
    DetailedRecordView()
}
