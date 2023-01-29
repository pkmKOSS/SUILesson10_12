//  VerificationView.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 24.01.2023.
//

import SwiftUI

/// Экран верификации
struct VerificationView: View {

    // MARK: - Private constants

    private enum Constants {
        static let envelopeImageName = "envelope"
        static let envelopeImageNameHeight: CGFloat = 400
        static let envelopeImageScaleCoef: CGFloat = 7
        static let envelopeImageYOffset: CGFloat = 150
        static let envelopeImageViewWidth: CGFloat = 150
        static let envelopeImageViewHeight: CGFloat = 150
        static let verificationCodeTextViewName = "Verification Code"
        static let emptyString = ""
        static let navigationTitleText = "Verification"
        static let checkSmsTextViewText = "Check the SMS"
        static let checkSmsTextViewSubtitleText = "Massageto geta verification code"
        static let continueButtonViewText = "Continue"
        static let continueButtonAlertText = "We already know about the bug and fix it sooon"
        static let didntReceiveSmsButtonViewText = "Did't recieve sms"
        static let sendSmsAgainButtonText = "Send sms again"
        static let sendSmsAgainAlertText = "Использовать код"
        static let maxCountOfCodeField = 1
    }

    // MARK: - Public properties

    var body: some View {
        backgroundView
    }
    
    // MARK: - private properties

    @StateObject private var viewModel = VerificationScreenViewModel()
    @FocusState private var isFirstTextFieldFocused: Bool
    @FocusState private var isSecondTextFieldFocused: Bool
    @FocusState private var isThirdTextFieldFocused: Bool
    @FocusState private var isFoursTextFieldFocused: Bool

    @State private var isLoading = false
    @State private var isContineShown = false
    @State private var isCodeShown = false

    private var backgroundView: some View {
        VStack {
            ZStack {
                verificationView
                if viewModel.isLoading {
                    continueLoadingView
                }
            }
        }
        .navigationTitle(Text(Constants.navigationTitleText))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color.yellow, Color.red.opacity(1.0)], startPoint: .leading, endPoint: .trailing))
    }

    private var verificationView: some View {
        VStack {
            envelopeImageView
            verificationCodeTextView
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack(spacing: 15) {
                firstTextFieldView
                secondTextFieldView
                thirdTextFieldView
                foursTextFieldView
            }
            checkSmsTextView
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            continueButtonView
            didntReceiveSmsButtonView
            sendSmsAgainButtonView
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .padding(EdgeInsets(top: 65, leading: 0, bottom: 0, trailing: 0))
    }

    private var envelopeImageView: some View {
        Image(systemName: Constants.envelopeImageName)
            .resizable()
            .modifier(EnvelopeImageViewModifier())
    }

    private var verificationCodeTextView: some View {
        Text(Constants.verificationCodeTextViewName)
            .font(.title2)
            .bold()
            .foregroundColor(.black)
    }

    private var firstTextFieldView: some View {
        TextField(Constants.emptyString, text: $viewModel.firstTextFieldText)
            .modifier(NumberTextFieldViewModifier())
            .focused($isFirstTextFieldFocused)
            .onChange(of: viewModel.firstTextFieldText) { newValue in
                guard newValue.count == Constants.maxCountOfCodeField else { return }
                self.isSecondTextFieldFocused = true
            }
    }

    private var secondTextFieldView: some View {
        TextField(Constants.emptyString, text: $viewModel.secondTextFieldText)
            .modifier(NumberTextFieldViewModifier())
            .onChange(of: viewModel.secondTextFieldText) { newValue in
                guard newValue.count == Constants.maxCountOfCodeField else { return }
                self.isThirdTextFieldFocused = true
            }
            .focused($isSecondTextFieldFocused)
    }

    private var thirdTextFieldView: some View {
        TextField(Constants.emptyString, text: $viewModel.thirdTextFieldText)
            .modifier(NumberTextFieldViewModifier())
            .focused($isThirdTextFieldFocused)
            .onChange(of: viewModel.thirdTextFieldText) { newValue in
                guard newValue.count == Constants.maxCountOfCodeField else { return }
                self.isFoursTextFieldFocused = true
            }
    }

    private var foursTextFieldView: some View {
        TextField(Constants.emptyString, text: $viewModel.foursTextFieldText)
            .modifier(NumberTextFieldViewModifier())
            .focused($isFoursTextFieldFocused)
            .onChange(of: viewModel.foursTextFieldText) { newValue in
                guard newValue.count == Constants.maxCountOfCodeField else { return }
                self.isFoursTextFieldFocused = false
            }
    }

    private var checkSmsTextView: some View {
        VStack {
            Text(Constants.checkSmsTextViewText)
                .bold()
                .font(.title)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0))
            Text(Constants.checkSmsTextViewSubtitleText)
                .font(Font.system(size: 20, design: .default))
        }
    }

    private var continueButtonView: some View {
        Button {
            self.viewModel.load()
            self.isContineShown = true
        } label: {
            Text(Constants.continueButtonViewText)
        }
        .modifier(ContinueButtonViewModifier())
        .confirmationDialog(Constants.emptyString, isPresented: $isContineShown) {} message: {
            Text(Constants.continueButtonAlertText)
        }

    }

    private var didntReceiveSmsButtonView: some View {
        Button {
            self.isContineShown = true
        } label: {
            Text(Constants.didntReceiveSmsButtonViewText)
        }
        .modifier(SendMessageButtonViewModifier())
    }

    private var sendSmsAgainButtonView: some View {
        Button {
            self.isCodeShown = true
        } label: {
            Text(Constants.sendSmsAgainButtonText)
        }
        .modifier(SendMessageButtonViewModifier())
        .alert(isPresented: $isCodeShown) {
            Alert(
                title: Text("\(viewModel.codeFirstNumber)\(viewModel.codeSecondNumber)\(viewModel.codeThirdNumber)\(viewModel.codeFoursNumber)"),
                dismissButton: .default(Text(Constants.sendSmsAgainAlertText), action: {
                    self.viewModel.putNumberInField()
                }))
        }.onDisappear {
            self.viewModel.putNumberInField()
        }
    }

    private var continueLoadingView: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .red)).scaleEffect(3)
    }
}
