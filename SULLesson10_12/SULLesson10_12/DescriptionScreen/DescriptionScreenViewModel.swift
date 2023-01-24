//
//  DescriptionScreenViewModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import Foundation

/// Модель экрана с описанием мебели.
final class DescriptionScreenViewModel: ObservableObject {

    // MARK: - Private constants

    private enum Constants {
        static let emptyText = ""
        static let defaultProgressValue: Double = 0.0
    }

    // MARK: - Public properties

    @Published var progressValue = Constants.defaultProgressValue
    @Published var descriptionText = Constants.emptyText

    // MARK: - Public methods

    func calculateTextCount() {
        progressValue = Double(descriptionText.count)
    }
}
