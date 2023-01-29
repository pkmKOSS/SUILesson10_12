//  FurnitureAssortment.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import Foundation

/// Ассортимент мебели
enum FurnitureAssortment {
    /// Мебель
    static let furnitures = [
        Furniture(name: "Sofa", imageName: "1", cost: 970, discount: 0.4),
        Furniture(name: "Bed", imageName: "2", cost: 673, discount: 0.5),
        Furniture(name: "Chair", imageName: "3", cost: 531, discount: 0.3),
        Furniture(name: "Pedestal", imageName: "4", cost: 500, discount: 0.37),
        Furniture(name: "Coffee table", imageName: "5", cost: 120, discount: 0.5),
        Furniture(name: "Cupboard", imageName: "6", cost: 270, discount: 0.2),
        Furniture(name: "Table", imageName: "7", cost: 271, discount: 0.7),
        Furniture(name: "Pew", imageName: "8", cost: 70, discount: 0.1),
    ]
}
