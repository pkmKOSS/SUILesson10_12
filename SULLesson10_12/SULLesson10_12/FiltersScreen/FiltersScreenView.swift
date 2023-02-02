//  FiltersScreen.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import SwiftUI

/// Экран с настройкой фильтрации результатов поиска
struct FiltersScreenView: View {

    // MARK: - Private constants

    private enum Constants {
        static let cateforyTextViewText = "Category"
        static let moreViewText = "More"
        static let moreViewImageName = "chevron.right"
        static let pricingSliderViewText = "Pricing"
        static let colorViewText = "Colors"
        static let maxPriceText = "100$"
        static let minPriceText = "5000$"
    }

    // MARK: - Public properties

    var body: some View {
        VStack {
            contentView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color.yellow, Color.red], startPoint: .leading, endPoint: .trailing))
    }

    // MARK: - Private properties

    private let columns = [GridItem(), GridItem(), GridItem(), GridItem()]

    @StateObject private var viewModel = FilterScreenViewModel()

    @State private var pricingValue = 0.0


    private var contentView: some View {
        VStack(spacing: 0) {
            headTitleView
                .background(Color.white)
            categoryScrollView
                .background(Color.white)
            pricingSliderView
                .background(Color.white)
            colorsView
                .background(Color.white)
        }
        .padding(.top)
    }

    private var headTitleView: some View {
        HStack {
            categoryTextView
            Spacer()
            moreView
        }
    }

    private var categoryTextView: some View {
        Text(Constants.cateforyTextViewText)
            .font(.title)
            .bold()
            .padding(.leading)
    }

    private var moreView: some View {
        HStack {
            Text(Constants.moreViewText)
                .foregroundColor(.gray.opacity(0.4))
                .font(.title)
                .bold()
            Image(systemName: Constants.moreViewImageName)
                .resizable()
                .modifier(ShowMoreImageModifier())
        }
        .padding([.top, .bottom])
    }

    private var categoryScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            categoryViewsInStackView
        }
        .scaledToFit()
        .offset(y: -25)
    }

    private var categoryViewsInStackView: some View {
        HStack(spacing: 0) {
            ForEach(self.viewModel.imageNames, id: \.self) { imageNames in
                makeCategoryView(imageName: imageNames)
            }
        }
        .padding(.top)
    }

    private var pricingSliderTitleView: some View {
        HStack{
            Text(Constants.pricingSliderViewText)
                .foregroundColor(.black)
                .font(.title)
                .bold()
                .padding(.leading)
            Spacer()
        }
    }

    private var priceLimitsView: some View {
        HStack {
            Text(Constants.minPriceText)
                .padding(.leading)
            Spacer()
            Text(Constants.maxPriceText)
                .padding(.trailing)
        }
    }

    private var pricingSliderView: some View {
        VStack(spacing: 5) {
            pricingSliderTitleView

            Text("\(Int(pricingValue))")

            SwiftUISlider(
                value: $pricingValue,
                thumbColor: .orange
            )
            .accentColor(.purple)
            .padding()

            priceLimitsView
        }
        .padding(.bottom)
    }

    private var colorsView: some View {
        VStack {
            HStack {
                Text(Constants.colorViewText)
                    .foregroundColor(viewModel.colorTextViewColor)
                    .font(.title)
                    .bold()
                    .padding(.leading)
                Spacer()
            }
            ScrollView {
                colorsVGridView
            }
        }
    }

    private var colorsVGridView: some View {
        LazyVGrid(columns: columns, spacing: 35) {
            ForEach(viewModel.colors, id: \.self) { color in
                makeColorsHStackView(color: color)
            }
        }
    }

    private func makeColorsHStackView(color: Color) -> some View {
        Button {
            self.viewModel.setTextColor(color: color)
        } label: {
            ZStack {
                Circle()
                    .fill(color)
                Circle()
                    .stroke(.gray, lineWidth: 3)
            }
        }
        .frame(width: 35, height: 35)
    }

    // MARK: - Private methods

    private func makeCategoryView(imageName: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .shadow(radius: 5)
                .foregroundColor(.white)
                .padding()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 90)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .scaledToFit()
        .frame(width: 140,height: 130)
    }
}
