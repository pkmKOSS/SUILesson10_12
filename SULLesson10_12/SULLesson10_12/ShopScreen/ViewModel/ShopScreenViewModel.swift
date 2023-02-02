//  ShopScreenViewModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import Foundation

/// Вью модель экрана покупок
final class ShopScreenViewModel: ObservableObject {

    // MARK: - Public properties

    @Published var totalCost = 0.0

    // MARK: - Public methods

    func incrementTotalCost(cost: Double) {
        totalCost += cost
    }

    func decrementTotalCost(cost: Double) {
        guard
            cost <= totalCost
        else {
            totalCost = 0
            return
        }
        totalCost -= cost
    }
}
