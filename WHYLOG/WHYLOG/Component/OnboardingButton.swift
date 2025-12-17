//
//  OnboardingButton.swift
//  WHYLOG
//
//  Created by 김종수 on 12/17/25.
//

import SwiftUI

struct OnboardingNavigationBar<Destination: View>: View {
    let title: String
    let action: () -> Void
    let destination: Destination
    
    @State private var isNextActive: Bool = false
    
    init(title: String, action: @escaping () -> Void, destination: Destination) {
        self.title = title
        self.action = action
        self.destination = destination
    }
    
    var body: some View {
        Button(action: {
            action()
            isNextActive = true
        }) {
                    Text(title)
                        .foregroundColor(Color.white)
                        .font(.PretendardBold16)
                        .padding(.vertical,18)
                }.modifier(OnboardingNavigationBarStyle())
            .navigationDestination(isPresented: $isNextActive){
                destination
            }
        }
    }

struct OnboardingNavigationBarStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth:.infinity)
            .background(Color.accentCoral)
            .cornerRadius(18)
            .padding(.horizontal,18)
    }
}
