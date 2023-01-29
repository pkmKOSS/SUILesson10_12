//  NotificationScreen.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import SwiftUI

/// Экран уведомлений
struct NotificationScreen: View {

    // MARK: - Private constants

    private enum Constants {
        static let updateSettingsText = "Update settings"
        static let productUpdatesText = "Product updates"
        static let emptyText = ""
        static let notificationFieldViewText = "Stair lifts free the freedom of ypour home"
        static let notificationFormViewRange = 0..<4
    }

    // MARK: - Public properties

    var body: some View {
        ZStack {
            contentView.background(Color.white)
        }
        .modifier(NotificationBodyModifier())
    }

    // MARK: - Private properties

    @State private var isUpdatesToggleOn = false

    private var notificationScrollView: some View {
        ScrollView {
            notificationFormView
        }.padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))

    }

    private var contentView: some View {
        VStack {
            notificationScrollView
            Text(Constants.updateSettingsText)
                .modifier(NotificationContentViewTextModifier())
                
        }
    }

    private var notificationFormView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .shadow(radius: 5)
                .foregroundColor(.white)
            VStack {
                ForEach(Constants.notificationFormViewRange) { _ in
                    notificationFieldView
                }
            }
            .padding()
        }
        .scaledToFit()
        .padding()
    }

    private var notificationFieldView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(Constants.productUpdatesText)
                    .font(Font.system(size: 17))
                    .bold()
                    .font(.title3)
                Toggle(Constants.emptyText, isOn: $isUpdatesToggleOn)
                    .accentColor(.orange)
            }
            Text(Constants.notificationFieldViewText)
                .font(Font.system(size: 13))
            Divider()
                .foregroundColor(.gray)
        }
    }
}
