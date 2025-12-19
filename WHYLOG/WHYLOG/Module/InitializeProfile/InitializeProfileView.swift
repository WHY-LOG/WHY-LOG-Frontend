//
//  InitializeProfileView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/17/25.
//

import SwiftUI
import PhotosUI

struct InitializeProfileView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @StateObject private var myProfileModel = ProfileModel()
    @State private var username: String = ""
    @State private var userEmail: String = ""
    var body: some View {
            ZStack{
                Color.baseCoral
                    .ignoresSafeArea()
                VStack{
                    HStack(){
                        Text("프로필 정보를 입력해주세요")
                            .font(.PretendardBold20)
                            .foregroundColor(.gray525252)
                        Spacer()
                    }.padding(.top,60)
                    EditableCircleProfileImage(viewModel: myProfileModel)
                        .padding(.top,65)
                    PrimaryTextField(placeholder: "이름을 입력하세요", text: $myProfileModel.name)
                        .padding(.top,32)
                    PrimaryTextField(placeholder: "이메일을 입력하세요", text: $myProfileModel.email)
                        .padding(.vertical,24)
                    
                    Spacer()
//                    PrimaryButton(title: "완료", action: {}, destination: FirstServiceGuideView())

                    PrimaryButton(title: "완료", action: {}, destination: FirstServiceGuideView())
                    

                        
//                        Image(systemName: "plus")
//                            .resizable()
//                            .frame(width: 30,height: 30)
//                            .foregroundColor(Color.gray949494)
//                            .background(){
//                                Circle()
//                                .stroke(Color.gray949494, lineWidth: 2)
//                                .fill(Color.grayE3E3E3)
//                                .frame(width: 123, height: 123)
//                    }
                }.padding(.horizontal,20)
            }
        }
    }

struct EditableCircleProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    
    var body: some View {
        CircleProfileImage(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing){
                PhotosPicker(
                    selection: $viewModel.imageSelection,
                    matching: .images
                ){
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentBlue)
                }.buttonStyle(.borderless)
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
