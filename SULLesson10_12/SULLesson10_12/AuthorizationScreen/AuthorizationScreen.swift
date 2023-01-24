//
//  AuthorizationScreen.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 24.01.2023.
//

import SwiftUI

/// Экран авторизации
struct AuthorizationView: View {

    // MARK: - Public enums

    enum Scenario: String {
        case LogIn = Constants.loginButtonText
        case SingUp = Constants.signUpButtonText
    }

    // MARK: - Private constants

    private enum Constants {
        static let mask = "+0(000) 000-00-00"
        static let backgroundViewColorOpacity: Double = 1
        static let emptyString = ""
        static let authorizationViewYOffset: CGFloat = 30
        static let screenScenarioPickerViewCornerRadius: CGFloat = 15
        static let screenScenarioPickerViewWidth: CGFloat = 150
        static let screenScenarioPickerViewScaleCoef: CGFloat = 2
        static let screenScenarioPickerViewScaleEdgeInsets = EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0)
        static let loginButtonText = "Log in"
        static let signUpButtonText = "Sign up"
        static let passwordTitleText = "Password"
        static let checkVerificationButtonText = "Check verification"
        static let secureFieldPlaceholder = "● ● ● ● ● ● ●"
        static let forgotYourPasswordLinkText = "Forgot your password?"
        static let forgotYourPasswordAlertText = "Forgot your password? Call 8-800-555-35-35"
        static let maxCountOfLoginText = 17
    }

    // MARK: - public properties

    var body: some View {
        backgroundView
    }

    // MARK: - init

    init() {
        UITextField.appearance().textColor = .black
    }

    // MARK: - private properties

    @FocusState private var loginFocusState: Bool
    @FocusState private var passwordFocusState: Bool
    @ObservedObject private var viewModel = AuthorizationViewModel()
    @State private var scenarioPickerSelect = Scenario.LogIn
    @State private var loginText = Constants.emptyString
    @State private var passwordText = Constants.emptyString
    @State private var logInSegmentButton = Color.white
    @State private var signUpSegmentButton = Color.gray
    @State private var isForgotPasswordShown = false


    private let scenarioVarables = [Scenario.LogIn, Scenario.SingUp]
    private var backgroundView: some View {
        VStack {
            authorizationView
                .frame(maxWidth: .infinity).padding(EdgeInsets(top: 150, leading: 0, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity)
        .background(LinearGradient(
            colors: [Color.yellow, Color.red.opacity(Constants.backgroundViewColorOpacity)],
            startPoint: .leading,
            endPoint: .trailing))
    }

    private var authorizationView: some View {
        VStack() {
            screenScenarioPickerView
            loginTextFieldView
            passwordTextView
            passwordTextFieldView.offset(y: -30)
            checkVerificationButtonView
            continueButtonView
            restorePasswordNavLinkView
        }
        .background(Color.white)
    }

    private var logInButtonView: some View {
        Button {
            self.signUpSegmentButton = .gray.opacity(0.2)
            self.logInSegmentButton = .white
        } label: {
            Text(Constants.loginButtonText)
                .foregroundColor(.indigo)
                .font(.title)
                .bold()
        }
        .frame(width: 157, height: 75)
        .background(logInSegmentButton)
        .cornerRadius(40, corners: [.topLeft, .bottomLeft])
    }

    private var signUpSegmentButtonView: some View {
        Button {
            self.signUpSegmentButton = .white
            self.logInSegmentButton = .gray.opacity(0.2)
        } label: {
            Text(Constants.signUpButtonText)
                .foregroundColor(.indigo)
                .font(.title)
                .bold()
        }
        .frame(width: 157, height: 75)
        .background(signUpSegmentButton.opacity(0.2))
        .cornerRadius(40, corners: [.topRight, .bottomRight])
    }

    private var screenScenarioPickerView: some View {
        HStack(spacing: 2) {
            logInButtonView
            signUpSegmentButtonView
        }
        .frame(width: 320, height: 80)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(40)
        .padding(Constants.screenScenarioPickerViewScaleEdgeInsets)
    }

    private var loginTextFieldView: some View {
        TextField(Constants.mask, text: Binding(get: {
            self.loginText
        }, set: { newValue in
            guard newValue.count <= Constants.maxCountOfLoginText else { return }
            self.loginText = newValue.format(with: Constants.mask)
        }))
        .modifier(LoginTextfieldModifier())
        .focused($loginFocusState)
        .onChange(of: loginText) { newValue in
            guard loginText.count == Constants.maxCountOfLoginText else { return }
            self.passwordFocusState = true
        }
    }

    private var passwordTextView: some View {
        HStack {
            Text(Constants.passwordTitleText)
                .padding()
                .font(Font.system(size: 25, design: .default))
            Spacer()
        }
    }

    private var passwordTextFieldView: some View {
        SecureField(Constants.secureFieldPlaceholder, text: Binding(get: {
            self.viewModel.passwordText
        }, set: { newValue in
            self.viewModel.enterPassword(password: newValue)
        }))
            .modifier(PasswordTextFieldSecureModifier())
            .focused($passwordFocusState)
    }

    private var checkVerificationButtonView: some View {
        NavigationLink(Constants.checkVerificationButtonText, destination: VerificationView())
            .modifier(CheckVerificationNavLinkModifier())
    }

    private var continueButtonView: some View {
        NavigationLink(Constants.signUpButtonText, destination: DescriptionView())
            .modifier(GetStartedButtonViewModifier())
            .disabled(!viewModel.isPasswordValid)
    }

    private var restorePasswordNavLinkView: some View {
        Button {
            self.isForgotPasswordShown = true
        } label: {
            Text(Constants.forgotYourPasswordLinkText)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 180, trailing: 0))
                .font(Font.system(size: 20, design: .default))
                .foregroundStyle(LinearGradient(colors: [.purple, .red], startPoint: .leading, endPoint: .trailing))
        }
        .alert(Constants.forgotYourPasswordAlertText, isPresented: $isForgotPasswordShown) {
            Text(Constants.emptyString)
        }
    }
}
