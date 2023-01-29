//  Modifiers.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 30.01.2023.
//

import SwiftUI

/// Модификатор главного представления экрана с уведомлениями
struct NotificationBodyModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .padding(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [Color.yellow, Color.red], startPoint: .leading, endPoint: .trailing))
    }
}

/// Модификатор представления с контентом экрана с уведомлениями
struct NotificationContentViewTextModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .font(.title)
            .bold()
            .frame(width: 300, height: 70)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(30, corners: .allCorners)
            .offset(y: -50)
    }
}
