//  FilterScreenViewModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import SwiftUI

/// Модель экрана с настройками фильтра поиска
final class FilterScreenViewModel: ObservableObject {

    // MARK: - Private constants

    private enum Constants {
        static let sofaImageName = "1"
        static let bedImageName = "2"
        static let chairImageName = "3"
        static let pedestalImageName = "4"
        static let coffeTableImageName = "5"
        static let cupBoardImageName = "6"
        static let tableImageName = "7"
        static let pewImageName = "8"
    }

 // MARK: - Public properties

 @Published var colorTextViewColor: Color = .black
 @Published var colors: [Color] = [
        .yellow,
        .green,
        .purple,
        .pink,
        .blue,
        .orange,
        .gray,
        .indigo,
        .secondary,
        .accentColor,
        .mint,
        .brown,
        .cyan,
        .cyan.opacity(0.4),
        .green.opacity(0.4),
        .red.opacity(0.4),
        .blue.opacity(0.4)
    ]
    @Published var imageNames = [
        Constants.sofaImageName,
        Constants.bedImageName,
        Constants.chairImageName,
        Constants.pedestalImageName,
        Constants.coffeTableImageName,
        Constants.cupBoardImageName,
        Constants.tableImageName,
        Constants.pewImageName
    ]

    // MARK: - Public methods

    func setTextColor(color: Color) {
        colorTextViewColor = color
    }
}
