//  ProfileScreenModifiers.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 30.01.2023.
//

import SwiftUI

/// Модификатор изображения  в поле профиля
struct ProfileFieldsImageModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .foregroundColor(.gray)
            .scaledToFit()
            .frame(width: 25, height: 25)
    }
}

/// Модификатор текста поля профиля
struct ProfileFieldsTextModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .frame(width: 25, height: 25)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(15, corners: .allCorners)
            .bold()
    }
}
