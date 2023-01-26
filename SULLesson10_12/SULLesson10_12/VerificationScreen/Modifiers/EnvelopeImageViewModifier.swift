//
//  EnvelopeImageViewModifier.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import SwiftUI

/// Модификатор изображения верификации
struct EnvelopeImageViewModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 150, height: 150)
            .foregroundColor(Color.gray)
            .padding(EdgeInsets(top: 45, leading: 0, bottom: 20, trailing: 0))
    }
}
