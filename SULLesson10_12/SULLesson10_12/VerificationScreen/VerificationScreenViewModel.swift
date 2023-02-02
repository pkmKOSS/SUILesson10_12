//  VerificationScreenViewModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import Foundation

/// Модель экрана верификации.
final class VerificationScreenViewModel: ObservableObject {

    // MARK: - Private constants

    private enum Constants {
        static let emptyString = ""
        static let randomNamber = Int.random(in: 0...9)
    }

    // MARK: - Public properties

    @Published var isLoading = false
    @Published var codeFirstNumber = Constants.randomNamber
    @Published var codeSecondNumber = Constants.randomNamber
    @Published var codeThirdNumber = Constants.randomNamber
    @Published var codeFoursNumber = Constants.randomNamber
    @Published var firstTextFieldText = Constants.emptyString
    @Published var secondTextFieldText = Constants.emptyString
    @Published var thirdTextFieldText = Constants.emptyString
    @Published var foursTextFieldText = Constants.emptyString

    // MARK: - Public methods

    func load() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = false
        }
    }

    func putNumberInField() {
        firstTextFieldText = String(codeFirstNumber)
        secondTextFieldText = String(codeSecondNumber)
        thirdTextFieldText = String(codeThirdNumber)
        foursTextFieldText = String(codeFoursNumber)
    }
}
