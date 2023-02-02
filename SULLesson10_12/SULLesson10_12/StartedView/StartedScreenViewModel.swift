//
//  StartedScreenViewModel.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 03.02.2023.
//

import SwiftUI

final class StartedScreenViewModel: ObservableObject {

    @Published var isHeadTextShown = false
    @Published var isGetStartedButtonShow = false
    @Published var isSingHereShow = false
    @Published var fakeLoaderAmount = 0.0
    @Published var isFakeLoadingComplete = false
    @Published var isDeveloperAlertShown = false
    
    private var runCount = 0

    func showGetStartedButton() {
        self.isGetStartedButtonShow.toggle()
    }

    func showHeadText() {
        self.isHeadTextShown.toggle()
    }

    func showSingHereText() {
        self.isSingHereShow.toggle()
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.runCount += 1
            self.fakeLoaderAmount += 0.1
            if self.runCount == 10 {
                timer.invalidate()
                self.isFakeLoadingComplete.toggle()
            }
        }
    }
}
