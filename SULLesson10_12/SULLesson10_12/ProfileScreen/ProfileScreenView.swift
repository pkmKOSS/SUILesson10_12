//  ProfileScreen.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import SwiftUI

/// Экран с профайлом пользователя.
struct ProfileScreenView: View {

    // MARK: - Private constants

    private enum Constants {
        static let avatarImageName = "avatarPlaceholder"
        static let userNameTextViewText = "Your name"
        static let locationImageViewName = "mappin.and.ellipse"
        static let locationTextViewText = "City"
        static let messageListImageName = "envelope.fill"
        static let messagesTextViewText = "Messages"
        static let newMessagesCountText = "3"
        static let notificationTextViewText = "Notification"
        static let notificationImageName = "bell.fill"
        static let newNotificationCountText = "5"
        static let accountDetailsTextViewText = "Accounts Details"
        static let accountDetailsImageName = "person.fill"
        static let purchaseImageName = "cart.fill"
        static let purchaseTextViewText = "My purchase"
        static let settingsTextViewText = "Settings"
        static let settingsImageName = "gearshape.fill"
    }

    // MARK: - Public properties

    var body: some View {
        NavigationView {
            backgroundView
        }
    }

    // MARK: - Private properties

    private var backgroundView: some View {
        VStack {
            profilePreviewView
        }
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color.yellow, Color.red], startPoint: .leading, endPoint: .trailing))
    }

    private var profilePreviewView: some View {
        VStack {
            usersAvatarImageView
            userNameTextView
            locationTextView
            profileFieldsListView
        }
        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
        .background(Color.white)
    }

    private var usersAvatarImageView: some View {
        Image(Constants.avatarImageName)
            .resizable()
            .scaledToFit()
            .frame(height: 150)
    }

    private var userNameTextView: some View {
        Text(Constants.userNameTextViewText)
            .font(.title)
            .bold()
    }

    private var locationTextView: some View {
        HStack {
            Image(systemName: Constants.locationImageViewName)
                .foregroundColor(.red)
            Text(Constants.locationTextViewText)
        }
    }

    private var profileFieldsListView: some View {
        List {
            messagesListView
            notificationListView
            accountDetailsListView
            purchaseListView
            settingsListView
        }
        .scrollContentBackground(.hidden)
        .background(Color.white)
    }

    private var messagesListView: some View {
        NavigationLink(destination: EmptyView()) {
            HStack {
                Image(systemName: Constants.messageListImageName)
                    .resizable()
                    .modifier(ProfileFieldsImageModifier())
                VStack(spacing: 5) {
                    HStack {
                        Text(Constants.messagesTextViewText)
                            .font(Font.system(size: 20))
                        Spacer()
                        Text(Constants.newMessagesCountText)
                            .modifier(ProfileFieldsTextModifier())
                    }
                }
            }
        }
    }

    private var notificationListView: some View {
        NavigationLink(destination: NotificationScreenView()) {
            HStack {
                Image(systemName: Constants.notificationImageName)
                    .resizable()
                    .modifier(ProfileFieldsImageModifier())
                VStack(spacing: 5) {
                    HStack {
                        Text(Constants.notificationTextViewText)
                            .font(Font.system(size: 20))
                        Spacer()
                        Text(Constants.newNotificationCountText)
                            .modifier(ProfileFieldsTextModifier())
                    }
                }
            }
        }
    }

    private var accountDetailsListView: some View {
        NavigationLink(destination: EmptyView()){
            HStack {
                Image(systemName: Constants.accountDetailsImageName)
                    .resizable()
                    .modifier(ProfileFieldsImageModifier())
                VStack(spacing: 5) {
                    HStack {
                        Text(Constants.accountDetailsTextViewText)
                            .font(Font.system(size: 20))
                        Spacer()
                    }
                }
            }
        }
    }

    private var purchaseListView: some View {
        NavigationLink(destination: EmptyView()) {
            HStack {
                Image(systemName: Constants.purchaseImageName)
                    .resizable()
                    .modifier(ProfileFieldsImageModifier())
                VStack(spacing: 5) {
                    HStack {
                        Text(Constants.purchaseTextViewText)
                            .font(Font.system(size: 20))
                        Spacer()
                    }
                }
            }
        }
    }

    private var settingsListView: some View {
        NavigationLink(destination: EmptyView()) {
            HStack {
                Image(systemName: Constants.settingsImageName)
                    .modifier(ProfileFieldsImageModifier())
                VStack(spacing: 5) {
                    HStack {
                        Text(Constants.settingsTextViewText)
                            .font(Font.system(size: 20))
                        Spacer()
                    }
                }
            }
        }
    }
}
