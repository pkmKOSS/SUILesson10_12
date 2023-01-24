//
//  ContinueButtonViewModifier.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import SwiftUI

struct ContinueButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 270, height: 80)
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(45)
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
    }
}
