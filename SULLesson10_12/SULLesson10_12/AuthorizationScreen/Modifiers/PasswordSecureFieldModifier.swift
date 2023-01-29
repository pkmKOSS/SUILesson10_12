//  PasswordSecureFieldModifier.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import SwiftUI

/// Модификатор поля ввода пароля экрана авторизации
struct PasswordTextFieldSecureModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(height: 2)
                    .offset(y: 6),
                alignment: .bottom
            )
            .foregroundColor(.black)
            .font(.title)
            .multilineTextAlignment(.leading)
            .padding()
    }
}
