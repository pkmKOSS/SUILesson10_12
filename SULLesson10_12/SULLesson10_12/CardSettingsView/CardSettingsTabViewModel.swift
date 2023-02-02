//  CardSettingsTabViewModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 02.02.2023.
//

import SwiftUI

/// SettingsTab ViewModel
final class SettingsTabViewModel: ObservableObject {

    // MARK: - Private Constants

    private enum Constants {
        static let defaultCardNumberName = "0000 0000 0000 0000"
        static let ownerNameOnCard = "Your Name"
        static let defaultExpireMonthName = "05"
        static let defaultExpireYearName = "20"
        static let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
        static let years = ["23", "24", "25", "26", "27", "28", "29", "30"]
    }

    // MARK: - Public Properties

    let months = Constants.months
    let years = Constants.years
    let durationAndDelay: CGFloat = 0.3

    @Published var cardNumber = ""
    @Published var ownerName = ""
    @Published var expireDateName = ""
    @Published var month = Date.now
    @Published var expireMonth = "06"
    @Published var expireYear = "26"
    @Published var isMonthPickerShown = false
    @Published var isYearPickerShown = false
    @Published var cvcTextFieldText = ""

    @Published var ownerNameOnCardName = Constants.ownerNameOnCard
    @Published var cardNumberOnCardName = Constants.defaultCardNumberName
    @Published var expireMonthOnCardName = Constants.defaultExpireMonthName
    @Published var expireYearOnCardName = Constants.defaultExpireYearName

    @Published var backDegree = 0.0
    @Published var frontDegree = -90.0
    @Published var isFlipped = false

    @Published var isAlertAddingCardShown = false
    @Published var isAlertWrongCVC = false

    // MARK: - Public Methods

    func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0
            }
        }
    }

    func setOnCardOwnerName() {
        ownerNameOnCardName = ownerName
        if isFlipped == true {
            flipCard()
        }
    }

    func setOnCardNumberName(value: String) {
        cardNumberOnCardName = value
        cardNumber = value.formatString(with: "0000 0000 0000 0000")
        if isFlipped == true {
            flipCard()
        }
    }

    func setOnCardSecureCVC() {
        if isFlipped == false {
            flipCard()
        }
        if cvcTextFieldText.count > 3 {
            cvcTextFieldText
                .remove(
                    at: cvcTextFieldText
                        .index(before: cvcTextFieldText.endIndex)
                )
        }
    }
}
