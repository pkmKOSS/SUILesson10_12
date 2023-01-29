//  NumberTextFieldViewModifier.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import SwiftUI

/// Модификатор поля ввода экрана верификации
struct NumberTextFieldViewModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .frame(width: 70, height: 70)
            .font(Font.system(size: 60, design: .default))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay {
                RoundedRectangle(cornerRadius: 5).stroke(.gray.opacity(0.2), lineWidth: 5)
            }
    }
}
