//  FurnitureModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import Foundation

/// Описание мебели
struct Furniture: Identifiable {

    /// ID предмета мебели
    let id = UUID()
    /// Название предмета мебели
    let name: String
    /// Имя изображения предмета мебели
    let imageName: String
    /// Цена предмета мебели
    let cost: Double
    /// Скидка на предмет мебели
    let discount: Double
}
