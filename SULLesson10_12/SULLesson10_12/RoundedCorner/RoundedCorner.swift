//
//  RoundedCorner.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 25.01.2023.
//

import SwiftUI

/// Структура для закругления произвольных углов
struct RoundedCorner: Shape {

    // MARK: - Public properties

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    // MARK: - Public methods

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

/// Метод для закругления произвольных углов
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
