//
//  HomeView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.baseCoral
            .ignoresSafeArea()
            VStack{
                HStack{
                    Image("WHYLOGLogo")
                        .resizable()
                        .scaledToFit()
                }
            }
            
        }
    }
}

#Preview {
    HomeView()
}
