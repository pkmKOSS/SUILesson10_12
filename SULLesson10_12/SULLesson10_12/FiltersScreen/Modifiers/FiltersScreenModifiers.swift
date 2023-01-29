//  FiltersScreenModifiers.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 30.01.2023.
//

import SwiftUI

/// Модификатор главного представления экрана с уведомлениями
struct showMoreImageModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(.gray.opacity(0.4))
            .padding(.trailing)
            .bold()
    }
}
