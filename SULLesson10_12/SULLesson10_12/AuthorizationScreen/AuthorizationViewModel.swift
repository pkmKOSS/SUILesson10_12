//
//  AuthorizationViewModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import SwiftUI

/// Модель экрана авторизации
final class AuthorizationViewModel: ObservableObject {

    // MARK: - Public enums

    enum Scenario: String {
        case LogIn = "Log in"
        case SingUp = "Sign up"
    }

    // MARK: - Privat constants

    private enum Constants {
        static let emptyString = ""
        static let maxCountOfLoginText = 17
    }

    // MARK: - Pubic properties

    @Published var passwordText = Constants.emptyString
    @Published var isPasswordValid = false
    @Published var scenarioPickerSelect = Scenario.LogIn
    @Published var loginText = Constants.emptyString
    @Published var logInSegmentButton = Color.white
    @Published var signUpSegmentButton = Color.gray
    @Published var isForgotPasswordShown = false

    // MARK: - Public methods

    func enterPassword(password: String) {
        passwordText = password
        checkPassword()
    }

    func checkPasswordFieldCount() -> Bool {
        loginText.count == Constants.maxCountOfLoginText
    }

    // MARK: - private methods

    private func checkPassword() {
        guard
            passwordText.count <= 15,
            passwordText.count >= 6
        else { return  }
        isPasswordValid = true
    }
}
