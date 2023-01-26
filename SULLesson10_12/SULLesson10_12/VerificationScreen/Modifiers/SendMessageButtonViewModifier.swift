//
//  SendMessageButtonViewModifier.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import SwiftUI

/// Модификатор кнопки отправки кода
struct SendMessageButtonViewModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .frame(width: 270, height: 40)
            .font(.title2)
            .fontWeight(.heavy)
            .foregroundStyle(LinearGradient(colors: [.red, .purple], startPoint: .leading, endPoint: .trailing))
    }
}
