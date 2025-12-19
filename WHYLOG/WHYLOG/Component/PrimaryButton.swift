//
//  OnboardingButton.swift
//  WHYLOG
//
//  Created by 김종수 on 12/17/25.
//

import SwiftUI

struct PrimaryButton<Destination: View>: View {
    let title: String
    let action: () -> Void
    let destination: Destination
    
    let backgroundColor: Color
    let textColor: Color
    
    @State private var isNextActive: Bool = false
    
    init(title: String, action: @escaping () -> Void, destination: Destination, backgroundColor: Color = .accentCoral, textColor: Color = .white) {
        self.title = title
        self.action = action
        self.destination = destination
        self.backgroundColor = backgroundColor
        self.textColor = textColor
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
                }.modifier(PrimaryButtonStyle(backgroundColor: backgroundColor, textColor: textColor))
            .navigationDestination(isPresented: $isNextActive){
                destination
            }
        }
    }

struct PrimaryButtonStyle: ViewModifier {
    let backgroundColor: Color
    let textColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .frame(maxWidth:.infinity)
            .background(backgroundColor)
            .cornerRadius(18)
            .padding(.horizontal,18)
            
    }
}

struct PrimaryButtonColorStyle: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .background(color)
            
    }
}
