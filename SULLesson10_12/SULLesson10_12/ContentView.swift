//  StartedView.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 23.01.2023.
//

import SwiftUI

/// Тапбар навигации по приложению
struct TapView: View {

    // MARK: - Private constants

    private enum Constants {
        static let startedViewImageName = "house"
        static let shopViewImageName = "bag.fill"
        static let notificationViewImageName = "basket"
        static let profileViewImageName = "person.fill"
        static let filterViewImageName = "basket"
    }

    // MARK: - Public properties

    var body: some View {
        TabView(selection: $indexSelected) {
            StartedView()
                .tabItem {
                    Image(systemName: Constants.startedViewImageName)
                }
                .tag(0)
            ShopScreenView()
                .tabItem {
                    Image(systemName: Constants.shopViewImageName)
                }
                .tag(1)
            NotificationScreenView()
                .tabItem {
                    Image(systemName: Constants.notificationViewImageName)
                }
                .tag(2)
            ProfileScreenView()
                .tabItem {
                    Image(systemName: Constants.profileViewImageName)
                }
                .tag(3)
            FiltersScreenView()
                .tabItem {
                    Image(systemName: Constants.filterViewImageName)
                }
                .tag(4)
        }
    }

    // MARK: - Private properties

    @State private var indexSelected = 1
}

/// Превью контента 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TapView()
    }
}
