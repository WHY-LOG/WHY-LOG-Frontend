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
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.baseCoral
                    .ignoresSafeArea()
                VStack{
                    PhotosPicker(
                        selection: $selectedItems,
                        maxSelectionCount: 1,
                        matching: .images
                    ){
                        
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .foregroundStyle(Color.gray949494)
                            .background(){
                                Circle()
                                .fill(Color.grayE3E3E3)
                                .frame(width: 78, height: 78)
                                .border(Color.gray949494)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    InitializeProfileView()
}
