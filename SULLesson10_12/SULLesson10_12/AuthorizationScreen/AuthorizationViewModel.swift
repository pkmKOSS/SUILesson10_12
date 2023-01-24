//
//  AuthorizationViewModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 26.01.2023.
//

import Foundation

/// Модель экрана авторизации
final class AuthorizationViewModel: ObservableObject {

    // MARK: - Privat constants

    private enum Constants {
        static let emptyString = ""
    }

    // MARK: - Pubic properties

    @Published var passwordText = Constants.emptyString
    @Published var isPasswordValid = false

    // MARK: - Public methods

    func enterPassword(password: String) {
        passwordText = password
        checkPassword()
    }

    private func checkPassword() {
        guard
            passwordText.count <= 15,
            passwordText.count >= 6
        else { return  }
        isPasswordValid = true
    }
}
