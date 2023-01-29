//  SULLesson10_12App.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 23.01.2023.
//

import SwiftUI

@main
struct SULLesson10_12App: App {
    var body: some Scene {
        WindowGroup {
            TapView().background(LinearGradient(colors: [.yellow, .red], startPoint: .leading, endPoint: .trailing))
        }
    }
}
