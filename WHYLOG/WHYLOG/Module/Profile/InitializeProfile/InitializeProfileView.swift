//
//  InitializeProfileView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/17/25.
//

import SwiftUI
import PhotosUI

struct InitializeProfileView: View {
    @EnvironmentObject var profileModel: ProfileModel

    var body: some View {
        ZStack {
            Color.baseCoral
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text("프로필 정보를 입력해주세요")
                        .font(.PretendardBold20)
                        .foregroundColor(.gray525252)
                    Spacer()
                }
                .padding(.top, 60)

                EditableCircleProfileImage(
                    viewModel: profileModel,
                    isEditable: true        // ✅ 최초 설정은 수정 가능
                )
                .padding(.top, 65)

                PrimaryTextField(
                    placeholder: "이름을 입력하세요",
                    text: $profileModel.name
                )
                .padding(.top, 32)

                PrimaryTextField(
                    placeholder: "이메일을 입력하세요",
                    text: $profileModel.email
                )
                .padding(.vertical, 24)

                Spacer()

                PrimaryButton(
                    title: "완료",
                    action: {
                        // TODO: UserDefaults / 서버 저장
                    },
                    destination: FirstServiceGuideView()
                )
            }
            .padding(.horizontal, 20)
        }
    }
}


struct EditableCircleProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    let isEditable: Bool
    
    var body: some View {
        CircleProfileImage(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing) {
                if isEditable {
                    PhotosPicker(
                        selection: $viewModel.imageSelection,
                        matching: .images
                    ) {
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 30))
                            .foregroundColor(.accentBlue)
                    }
                    .buttonStyle(.borderless)
                }
            }
    }
}


struct CircleProfileImage: View {
    let imageState: ProfileModel.ImageState
    var body: some View{
        ProfileImage(imageState: imageState)
            .frame(width: 123, height: 123)
            .clipShape(Circle())
            .background{
                Circle()
                    .fill(
                        LinearGradient(colors: [.yellow, .orange],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    )
            }
    }
}

struct ProfileImage: View{
    let imageState: ProfileModel.ImageState
    var body: some View{
        switch imageState{
        case .success(let image):
            image
                .resizable()
                .scaledToFit()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
        }
    }
}



#Preview {
    InitializeProfileView()
}
