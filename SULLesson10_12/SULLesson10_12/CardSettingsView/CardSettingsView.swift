//
//  CardSettingsView.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 02.02.2023.
//

import SwiftUI

/// Представление экрана с настройками карты
struct SettingsTabView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let cardGradient = LinearGradient(
            colors: [.yellow, .red],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        static let cardTextName = "CARD"
        static let dateName = "valid"
        static let cardNumberPlacholderName = "0000 0000 0000 0000"
        static let addNewCardTextName = "Add new card"
        static let ownerPlaceHolderName = "Cardholder name"
        static let addCardButtonName = "Add now"
        static let backCardBankInfoName = "Обсуживание клиентов: 900, +7(495)500-5550"
        static let cvcTextName = "CVC"
        static let monthTextName = "Month"
        static let cvcTextFieldPlaceholder = "***"
        static let cardAddedAlertTitleName = "Card Added"
        static let chevronRightImageName = "chevron.right"
        static let wrongCVCAlertName = "Incorrect CVC"
        static let cvcCountOfNumbers = 3
        static let cardNumberTextName = "Card number"
        static let cardHolderTextName = "cardholder"
        static let yearTextName = "Year"
    }

    // MARK: - Public Properties

    var body: some View {
        VStack {
            cardPreviewView.padding()
            scrollPreferenceView
        }
    }

    // MARK: - Private Properties

    @FocusState private var isOnCVCFocus: Bool
    @FocusState private var isOnNameTextFieldFocus: Bool
    @FocusState private var isOnCardNumberFieldFocus: Bool
    @StateObject private var settingsTabViewModel = SettingsTabViewModel()

    private var cardFrontSide: some View {
        ZStack {
            cardFrontSideGradientView
            VStack(spacing: 10) {
                cardLogo
                cardNamberView
                cardNumberTitleView
                cardOwnerNameView
                cardValidDateView
            }.padding(.horizontal, 40).font(.title2)
        }
        .rotation3DEffect(
            Angle(
                degrees:
                    settingsTabViewModel.backDegree
            ),
            axis: (x: 0, y: 1, z: 0)
        )
    }

    private var cardFrontSideGradientView: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(
                height: 220
            )
            .foregroundStyle(Constants.cardGradient)
    }

    private var cardPreviewView: some View {
        ZStack {
            cardFrontSide
                .onTapGesture {
                    settingsTabViewModel.flipCard()
                }
            cardBackSideView
        }
    }

    private var scrollPreferenceView: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                VStack {
                    addNewCardView
                    cvcView
                    makeDataPickerView(scrollViewProxy: scrollViewProxy)
                }.padding(.horizontal, 40)
            }
            addNowButton
        }
    }

    private var cardLogo: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(
                        width: 80,
                        height: 40
                    )
                    .foregroundStyle(.white)
                Text(Constants.cardTextName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.indigo)
            }
        }
    }

    private var cardNamberView: some View {
        HStack {
            Text(settingsTabViewModel.cardNumberOnCardName)
                .fontWeight(.bold)
                .animation(.easeIn(duration: 3))
            Spacer()
        }
        .foregroundColor(.white)
    }

    private var cardNumberTitleView: some View {
        HStack {
            Text(Constants.cardNumberTextName)
                .fontWeight(.bold)
            Spacer()
        }
    }

    private var cardOwnerNameView: some View {
        HStack {
            Text(settingsTabViewModel.ownerNameOnCardName)
                .fontWeight(.bold)
                .animation(.easeIn(duration: 3))
            Spacer()
            Text("\(settingsTabViewModel.expireMonthOnCardName)/\(settingsTabViewModel.expireYearOnCardName)")
                .fontWeight(.bold)
        }
        .foregroundColor(.white)
    }

    private var cardValidDateView: some View {
        HStack {
            Text(Constants.cardHolderTextName)
                .fontWeight(.bold)
            Spacer()
            Text(Constants.dateName)
                .fontWeight(.bold)
        }
    }

    private var cardBackSideGradientView: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(
                height: 220
            )
            .onTapGesture {
                settingsTabViewModel.flipCard()
            }
            .foregroundStyle(Constants.cardGradient)
    }

    private var cardBackSideInfoView: some View {
        HStack {
            Text(Constants.backCardBankInfoName)
                .font(.caption)
                .padding(.horizontal, 20)
            Spacer()
        }
    }

    private var cardBackSideCVCView: some View {
        HStack {
            Spacer()
            Text(Constants.cvcTextName)
            ZStack {
                Rectangle()
                    .frame(
                        width: 100,
                        height: 50
                    )
                    .padding(.horizontal, 20)
                    .foregroundColor(Color(.systemBackground))
                SecureField(
                    Constants.cvcTextFieldPlaceholder,
                    text: $settingsTabViewModel.cvcTextFieldText
                )
                .frame(width: 100)
                .multilineTextAlignment(.center)
                .focused($isOnCVCFocus)
            }
        }
    }

    private var cardBackSideView: some View {
        ZStack {
            cardBackSideGradientView
            VStack {
                cardBackSideInfoView
                Rectangle()
                    .frame(
                        width: 360,
                        height: 50
                    )
                cardBackSideCVCView
            }
            .font(.title2)
            .offset(y: -35)
        }
        .rotation3DEffect(
            Angle(
                degrees:
                    settingsTabViewModel.frontDegree
            ),
            axis: (x: 0, y: 1, z: 0)
        )
    }

    private var addNewCardView: some View {
        VStack {
            HStack {
                Text(Constants.addNewCardTextName)
                    .font(.title)
                    .fontWeight(.bold)
                    .id(0)
                Spacer()
            }
            TextField(
                Constants.ownerPlaceHolderName,
                text: $settingsTabViewModel.ownerName
            )
            .onChange(of: settingsTabViewModel.ownerName) { _ in
                settingsTabViewModel.setOnCardOwnerName()
            }
            .focused($isOnNameTextFieldFocus)

            Divider()
            HStack {
                Text(Constants.cardNumberTextName)
                Spacer()
            }
            TextField(
                Constants.cardNumberPlacholderName,
                text: $settingsTabViewModel.cardNumber
            )
            .onChange(
                of: settingsTabViewModel.cardNumber,
                perform: { newValue in
                    settingsTabViewModel.setOnCardNumberName(value: newValue)
                }
            )
            .keyboardType(.numberPad)
            .focused($isOnCardNumberFieldFocus)
            Divider()
        }
    }

    private var cvcView: some View {
        VStack {
            HStack {
                Text(Constants.cvcTextName)
                Spacer()
            }
            SecureField(
                Constants.cvcTextFieldPlaceholder,
                text: $settingsTabViewModel.cvcTextFieldText
            )
            .onChange(of: settingsTabViewModel.cvcTextFieldText) { _ in
                settingsTabViewModel.setOnCardSecureCVC()
            }
            .onTapGesture {
                settingsTabViewModel.flipCard()
            }
            .keyboardType(.numberPad)
            Divider()
        }
    }

    // MARK: - Private Methods

    private func makeDataPickerView(scrollViewProxy: ScrollViewProxy) -> some View {
        VStack(alignment: .leading) {
                HStack {
                    Text(Constants.monthTextName)
                    Button {
                        withAnimation {
                            settingsTabViewModel.isMonthPickerShown.toggle()
                            scrollViewProxy.scrollTo(
                                settingsTabViewModel.isMonthPickerShown ? 1 : 0, anchor: .center
                            )
                        }
                    } label: {
                        Image(systemName: Constants.chevronRightImageName)
                    }
                    .frame(
                        width: 10,
                        height: 10
                    )
                    .rotationEffect(Angle.degrees(settingsTabViewModel.isMonthPickerShown ? 90 : 0))
                }
                HStack {
                    Text(Constants.yearTextName)
                    Button {
                        withAnimation {
                            settingsTabViewModel.isYearPickerShown.toggle()
                            scrollViewProxy.scrollTo(
                                settingsTabViewModel.isYearPickerShown ? 1 : 0, anchor: .center
                            )
                        }
                    } label: {
                        Image(systemName: Constants.chevronRightImageName)
                    }
                    .frame(
                        width: 10,
                        height: 10
                    )
                    .rotationEffect(Angle.degrees(settingsTabViewModel.isYearPickerShown ? 90 : 0))
                }

            HStack {
                Picker(
                    Constants.monthTextName,
                    selection: $settingsTabViewModel.expireMonth,
                    content: {
                        ForEach(settingsTabViewModel.months, id: \.self) { month in
                            Text("\(month)")
                        }
                    }
                )
                .pickerStyle(.wheel)
                .opacity(settingsTabViewModel.isMonthPickerShown ? 1 : 0)
                .onChange(of: settingsTabViewModel.expireMonth) { newValue in
                    withAnimation {
                        settingsTabViewModel.expireMonthOnCardName = newValue
                        settingsTabViewModel.isMonthPickerShown = false
                        scrollViewProxy.scrollTo(0, anchor: .center)
                    }
                }

                Picker(
                    Constants.yearTextName,
                    selection: $settingsTabViewModel.expireYear,
                    content: {
                        ForEach(settingsTabViewModel.years, id: \.self) { month in
                            Text("\(month)")
                        }
                    }
                )
                .pickerStyle(.wheel)
                .opacity(settingsTabViewModel.isYearPickerShown ? 1 : 0)
                .onChange(of: settingsTabViewModel.expireYear) { newValue in
                    withAnimation {
                        settingsTabViewModel.expireYearOnCardName = newValue
                        settingsTabViewModel.isYearPickerShown = false
                        scrollViewProxy.scrollTo(0, anchor: .center)
                    }
                }
                .id(1)
            }
        }
    }

    private var addNowButton: some View {
        Button {
            settingsTabViewModel.isAlertAddingCardShown = true

        } label: {
            Text(Constants.addCardButtonName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
        .background(
            Capsule()
                .foregroundColor(.red)
        )
        .alert(isPresented: $settingsTabViewModel.isAlertAddingCardShown) {
            if settingsTabViewModel.cvcTextFieldText.count == Constants.cvcCountOfNumbers {
                return Alert(title: Text(Constants.cardAddedAlertTitleName))
            } else {
                return Alert(title: Text(Constants.wrongCVCAlertName))
            }
        }
    }
}

