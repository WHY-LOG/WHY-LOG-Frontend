//
//  MyProfileView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import SwiftUI
import PhotosUI

struct MyProfileView: View {

    @EnvironmentObject var viewModel: ProfileViewModel
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
                            await viewModel.save() // 서버에 POST(PUT) 요청
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
                    title: alertType == .edit
                        ? "수정하시겠습니까?"
                        : "삭제하시겠습니까?",
                    message: alertType == .delete
                        ? "삭제 시 해당 내용이 모두 사라집니다."
                        : nil,
                    action: {
                        switch alertType {
                        case .edit:
                            isEditing = true
                        case .delete:
                            //profileModel.deleteProfile()
                            isEditing = false
                            dismiss()
                        }
                        showAlert = false
                    },
                    cancelAction: {
                        showAlert = false
                    }
                )
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
