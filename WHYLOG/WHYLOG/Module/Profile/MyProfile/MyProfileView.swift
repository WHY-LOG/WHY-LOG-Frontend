//
//  MyProfileView.swift
//  WHYLOG
//
//  Created by 김진서 on 12/20/25.
//

import SwiftUI

struct MyProfileView: View {
    @StateObject private var profileModel = ProfileModel()
    @Environment(\.dismiss) private var dismiss

    @State private var isEditing = false
    @State private var showAlert = false
    @State private var alertType: AlertType = .edit

    enum AlertType {
        case edit
        case delete
    }

    var body: some View {
        ZStack {
            Color.baseCoral.ignoresSafeArea()

            VStack {
                navigationBar

                EditableCircleProfileImage(
                    viewModel: profileModel,
                    isEditable: isEditing
                )
                .padding(.top, 40)

                PrimaryTextField(
                    placeholder: "이름을 입력해주세요",
                    text: $profileModel.name,
                    isDisabled: !isEditing
                )
                .padding(.top, 32)

                PrimaryTextField(
                    placeholder: "이메일을 입력해주세요",
                    text: $profileModel.email,
                    isDisabled: !isEditing
                )
                .padding(.top, 16)

                Spacer()

                PrimaryButton(
                    title: "완료",
                    //isDisabled: !isEditing,
                    action: {
                        isEditing = false
                        // TODO: 저장 로직 (UserDefaults / 서버)
                    },
                    destination: HomeView()
                )
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 20)

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
                            // TODO: 프로필 초기화
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
                .foregroundColor(.gray525252)

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
    MyProfileView()
}

