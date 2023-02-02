//
//  String+.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 24.01.2023.
//

import SwiftUI

/// Константы для метода - маски для телефонного номера
fileprivate enum Constants {
    static let emptyString = ""
    static let regex = "[^0-9]"
    static let placeHolderNumber: Character = "0"
    static let cardFormatName = "XXXX XXXX XXXX XXXX"
}

/// Форматирование телефонного номера.
extension String {
    func formatString(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: Constants.regex, with: Constants.emptyString, options: .regularExpression)
        var result = Constants.emptyString
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == Constants.placeHolderNumber {
                result.append(numbers[index])
                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
}
