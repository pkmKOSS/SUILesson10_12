//  AuthorizationScreen.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 24.01.2023.
//

import SwiftUI

/// Экран авторизации
struct AuthorizationView: View {

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

    private let scenarioVarables = [AuthorizationViewModel.Scenario.LogIn, AuthorizationViewModel.Scenario.SingUp]

    @StateObject private var viewModel = AuthorizationViewModel()
    
    @FocusState private var loginFocusState: Bool
    @FocusState private var passwordFocusState: Bool

    private var backgroundView: some View {
        ZStack {
            authorizationView
                .blur(radius: viewModel.isInvalidatePasswordAlertShown ? 10 : 0)
                .frame(maxWidth: .infinity).padding(EdgeInsets(top: 150, leading: 0, bottom: 0, trailing: 0))
            if viewModel.isInvalidatePasswordAlertShown {
                invalidPasswordAlertView
            }
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
            self.viewModel.signUpSegmentButton = .gray.opacity(0.2)
            self.viewModel.logInSegmentButton = .white
        } label: {
            Text(Constants.loginButtonText)
                .foregroundColor(.indigo)
                .font(.title)
                .bold()
        }
        .frame(width: 157, height: 75)
        .background(viewModel.logInSegmentButton)
        .cornerRadius(40, corners: [.topLeft, .bottomLeft])
    }

    private var signUpSegmentButtonView: some View {
        Button {
            self.viewModel.signUpSegmentButton = .white
            self.viewModel.logInSegmentButton = .gray.opacity(0.2)
        } label: {
            Text(Constants.signUpButtonText)
                .foregroundColor(.indigo)
                .font(.title)
                .bold()
        }
        .frame(width: 157, height: 75)
        .background(viewModel.signUpSegmentButton.opacity(0.2))
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
            self.viewModel.loginText
        }, set: { newValue in
            guard newValue.count <= Constants.maxCountOfLoginText else { return }
            self.viewModel.loginText = newValue.formatString(with: Constants.mask)
        }))
        .modifier(LoginTextfieldModifier())
        .focused($loginFocusState)
        .onChange(of: viewModel.loginText) { newValue in
            self.passwordFocusState = viewModel.checkPasswordFieldCount()
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
            .modifier(ShakeEffect(animatableData: viewModel.isShaking))
            .focused($passwordFocusState)
            .onSubmit {
                withAnimation(Animation.spring()) {
                    viewModel.checkPassword()
                }
            }
    }

    private var checkVerificationButtonView: some View {
        NavigationLink(Constants.checkVerificationButtonText, destination: VerificationView())
            .modifier(CheckVerificationNavLinkModifier())
    }

    private var continueButtonView: some View {
        NavigationLink(Constants.signUpButtonText, destination: DescriptionView())
            .disabled(!viewModel.isPasswordValid)
            .modifier(GetStartedButtonViewModifier())
    }

    private var restorePasswordNavLinkView: some View {
        Button {
            self.viewModel.isForgotPasswordShown = true
        } label: {
            Text(Constants.forgotYourPasswordLinkText)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 180, trailing: 0))
                .font(Font.system(size: 20, design: .default))
                .foregroundStyle(LinearGradient(colors: [.purple, .red], startPoint: .leading, endPoint: .trailing))
        }
        .alert(Constants.forgotYourPasswordAlertText, isPresented: $viewModel.isForgotPasswordShown) {
            Text(Constants.emptyString)
        }
    }

    private var invalidPasswordAlertView: some View {
        VStack {
            Text("Warong password!")
                .padding(.all, 15)
            Button("Repeat") {
                viewModel.isInvalidatePasswordAlertShown = false
            }
            .foregroundColor(.white)
            .font(Font.system(size: 25))
            .padding([.leading, .trailing, .bottom])
        }
        .background(Color.gray)
        .cornerRadius(15)
    }
}
