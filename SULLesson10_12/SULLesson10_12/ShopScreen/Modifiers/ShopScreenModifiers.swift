//  ShopScreenModifiers.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 30.01.2023.
//

import SwiftUI

/// Модификатор текста с общей ценой
struct TotalCostTextModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .font(.title)
            .bold()
            .frame(width: 200, height: 50)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(20, corners: .allCorners)
            .offset(y: -195)
    }
}

/// Модификатор изображений search bar"a
struct SearchBarImageModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 25, height: 25)
            .foregroundColor(.gray.opacity(0.4))
            .padding(.leading)
    }
}

/// Модификатор  search bar"a
struct SearchBarModifier: ViewModifier {

    // MARK: - Public methods

    func body(content: Content) -> some View {
        content
            .frame(width: 350, height: 55)
            .background(Color.white)
            .cornerRadius(25, corners: .allCorners)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}




