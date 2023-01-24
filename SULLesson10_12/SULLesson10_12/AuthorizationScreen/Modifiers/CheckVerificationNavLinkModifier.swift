//
//  CheckVerificationNavLinkModifier.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import SwiftUI

struct CheckVerificationNavLinkModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 135, height: 40)
            .font(Font.system(size: 15, design: .default))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(35)

    }
}
