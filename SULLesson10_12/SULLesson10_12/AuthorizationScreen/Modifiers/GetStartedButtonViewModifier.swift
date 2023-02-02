//  GetStartedButtonViewModifier.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import SwiftUI

/// Модификатор кнопки завершения верификации
struct GetStartedButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 270, height: 80)
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(35)
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 25, trailing: 0))
    }
}
