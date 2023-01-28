//
//  DescriptionView.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 24.01.2023.
//

import SwiftUI

/// Экран с описанием фильма
struct DescriptionView: View {

    // MARK: - Private constants

    private enum Constants {
        static let descriptionText = ""
        static let descriptionViewEdgeInsets = EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        static let backgroundViewGradient = LinearGradient(colors: [Color.yellow, Color.red.opacity(1.0)], startPoint: .leading, endPoint: .trailing)
        static let descriptionViewImageName = "8"
        static let descriptionViewStackEdgeInsets = EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0)
        static let chairText = "Chair"
        static let costText = "$55"
        static let heartImageName = "heart"
        static let buyNowText = "Buy now"
        static let descriptionLabelText = "Description"
        static let bagImageName = "bag"
        static let emptyString = ""
        static let maxCountOfTextCharacter: Double = 150
    }

    // MARK: - Public properties

    var body: some View {
        backgroundView
    }

    // MARK: - Private properties

    @StateObject private var viewModel = DescriptionScreenViewModel()

    private var backgroundView: some View {
        VStack {
            descriptionView
                .padding(Constants.descriptionViewEdgeInsets)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Constants.backgroundViewGradient)
    }

    private var descriptionView: some View {
        VStack {
            Image(Constants.descriptionViewImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 190)
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                    .padding()
                badgeView
            }
            descriptionTitleTextView
        }
        .padding(Constants.descriptionViewStackEdgeInsets)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }

    private var chairCostView: some View {
        VStack(alignment: .leading) {
            Text(Constants.chairText)
                .font(.title)
                .bold()
            Divider()
                .frame(width: 65 ,height: 3)
                .background(Color.orange)
                .offset(y: -7)
            Text(Constants.costText)
                .font(Font.system(size: 45, design: .default))
                .bold()
                .foregroundColor(.purple)
                .offset(x: -10 ,y: -13)
        }
        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
    }

    private var buyButtonView: some View {
        VStack(alignment: .trailing) {
            Image(systemName: Constants.heartImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.red)
            Button {} label: {
                Text(Constants.buyNowText)
            }
            .frame(width: 120, height: 50)
            .bold()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(35)
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }

    private var badgeView: some View {
        HStack {
            chairCostView
            Spacer()
            buyButtonView
        }
        .frame(width: 300)
    }

    private var descriptionTitleTextView: some View {
        VStack {
            HStack {
                hangbagImageView
                VStack {
                    Text(Constants.descriptionLabelText)
                        .font(.title2)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 90))
                    textCountProgressView
                }
            }
            descriptionTextView
        }
        .frame(maxWidth: .infinity)
        .padding()
    }

    private var descriptionTextView: some View {
        TextEditor(text: $viewModel.descriptionText)
            .font(.title)
    }

    private var hangbagImageView: some View {
        Image(systemName: Constants.bagImageName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.yellow)
    }

    private var textCountProgressView: some View {
        ProgressView(Constants.emptyString, value: viewModel.progressValue, total: Constants.maxCountOfTextCharacter)
            .accentColor(.green)
            .onChange(of: viewModel.descriptionText.count) { _ in
            viewModel.calculateTextCount()
        }
    }
}
