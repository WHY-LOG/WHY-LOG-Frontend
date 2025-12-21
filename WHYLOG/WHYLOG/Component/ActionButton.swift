//
//  ActionButton.swift
//  WHYLOG
//
//  Created by 원서우 on 12/19/25.
//

import Foundation
import SwiftUI

struct ActionButtons: View {
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 16.84) {
            Button(action: onEdit) {
                Image("edit")
                   // .font(.system(size: 20))
            }
            Button(action: onDelete) {
                Image("delete")
                    //.font(.system(size: 20))
            }
        }
        .foregroundStyle(Color.gray525252)
    }
}
