//
//  MyProfileView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import SwiftUI
import PhotosUI
import Combine

struct MyProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var userSession = UserSession.shared
    @Environment(\.dismiss) private var dismiss

    @State private var isEditing: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertType: AlertType = .edit

    enum AlertType {
        case edit
        case delete
    }

    var body: some View {
        ZStack {
            Color.baseCoral
                .ignoresSafeArea()

            VStack {
                navigationBar

                EditableCircleProfileImage(
                    viewModel: viewModel,
                    isEditable: isEditing
                )
                .padding(.top, 40)

                // 이름
                PrimaryTextField(
                    placeholder: "이름을 입력해주세요",
                    text: $viewModel.name,
                    isDisabled: !isEditing
                )
                .padding(.top, 32)

                // 이메일
                PrimaryTextField(
                    placeholder: "이메일을 입력해주세요",
                    text: $viewModel.email,
                    isDisabled: !isEditing
                )
                .padding(.top, 16)

                Spacer()

                // 완료 버튼
                PrimaryButton(
                    title: "완료",
                    action: {
                        Task {
                            await viewModel.updateProfile() // 서버에 POST(PUT) 요청
                                isEditing = false
                            }
                    },
                    destination: HomeView()
                )
//                .disabled(!isEditing)
//                .opacity(isEditing ? 1 : 0.5)
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 20)

            // 삭제 / 수정 Alert
            if showAlert {
                CustomAlert(
                    title: alertType == .edit ? "수정하시겠습니까?" : "삭제하시겠습니까?",
                    message: alertType == .delete ? "삭제 시 해당 내용이 모두 사라집니다." : nil,
                    action: {
                        // ✅ 비동기 함수 호출을 위해 Task 블록 사용
                        Task {
                            switch alertType {
                            case .edit:
                                isEditing = true
                                showAlert = false // 수정 모드 진입 시 알럿 닫기
                                
                            case .delete:
                                // ✅ await를 사용하여 삭제 완료까지 기다림
                                let success = await viewModel.deleteProfile()
                                
                                if success {
                                    isEditing = true
                                    showAlert = false
                                    dismiss() // ✅ 삭제 성공 시에만 화면 이탈
                                } else {
                                    // 실패 처리 (필요시 에러 알럿 등을 띄울 수 있음)
                                    showAlert = false
                                }
                            }
                        }
                    },
                    cancelAction: {
                        showAlert = false
                    }
                )
            }
        }.task {
            print("👤 MyProfileView 진입 - 현재 세션 ID: \(userSession.userId ?? -1)")
            await viewModel.fetchProfile()
        }.onChange(of: userSession.userId) { oldId, newId in
            print("🔄 세션 아이디 변경 감지: \(oldId ?? -1) -> \(newId ?? -1)")
            Task {
                await viewModel.fetchProfile()
            }
        }
    }

    // MARK: - Navigation Bar
    private var navigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image("arrow_back")
                    .resizable()
                    .frame(width: 10.41, height: 17.71)
            }

            Spacer()

            Text("나의 프로필")
                .font(.PretendardBold16)
                .foregroundStyle(.gray525252)

            Spacer()

            ActionButtons(
                onEdit: {
                    alertType = .edit
                    showAlert = true
                },
                onDelete: {
                    alertType = .delete
                    showAlert = true
                }
            )
        }
        .padding(.top, 28.37)
        .padding(.bottom, 21)
    }
}
#Preview {
    // 통합된 ProfileViewModel을 주입
    MyProfileView(viewModel: ProfileViewModel())
}
