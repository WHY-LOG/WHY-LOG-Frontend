//
//  HomeView.swift
//  WHYLOG
//
//  Created by 김종수 on 12/19/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var selectedYear: Int = 2025
    @State private var selectedMonth: MonthListState = .Mar
    
    let months = Array(1...12)
    
    var body: some View {
        ZStack {
            Color.baseCoral
            .ignoresSafeArea()
            VStack(){
                HStack{
                    Image("WHYLOGLogo")
                        .resizable()
                        .frame(width: 97, height: 25)
                    EmotionDropdown()
                    Spacer()
                    NavigationLink {
                        ReportListView()
                    } label: {
                        Image(systemName: "text.document")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray525252)
                    }
                    NavigationLink {
                        ReportListView()
                    } label: {
                        Image("user")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray525252)
                    }
                }
                HStack(spacing: 20) {
                    Button(action: { selectedYear -= 1 }) {
                        Image("arrow_back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24,height: 24)
                            .foregroundColor(.gray525252)
                    }
                                
                    Text("\(String(selectedYear))")
                        .font(.PretendardBold20)
                                
                    Button(action: { selectedYear += 1 }) {
                        Image("arrow_front")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24,height: 24)
                            .foregroundColor(.gray525252)
                    }
                }.padding(.vertical, 20)
                            
                            // 2. 월 선택 (Horizontal Scroll)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach(MonthListState.allCases, id: \.self) { month in
                            MonthButton(state: month,isOn: selectedMonth == month,action: {
                                    withAnimation(.spring()){
                                        selectedMonth = month
                                    }
                                
                            })
                        }
                    }
                }
                Spacer()
                ScrollView{
                    VStack(spacing: 16){
                        ForEach(mockLogs){ recordCardModel in
                            RecordCard(recordCardModel: recordCardModel)
                        }
                    .zIndex(1)
                    }
                }
            }.padding(.horizontal,20)
            VStack{
                Spacer()
                addButton
            }
            
        }.navigationBarBackButtonHidden(true)
    }
}

private var addButton: some View {
            NavigationLink {
                CreateRecordView()
            } label: {
                AddButtonUI()
            }.padding(.bottom, 28)
        }


#Preview {
    HomeView()
}
