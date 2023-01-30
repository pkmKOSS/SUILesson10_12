//  ShopScreen.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import SwiftUI

/// Представление экрана покупок.
struct ShopScreenView: View {

    // MARK: - Private constants

    private enum Constants {
        static let bedImageName = "2"
        static let plusImageName = "plus"
        static let minusImageName = "minus"
        static let searchBarLeadingImageName = "magnifyingglass"
        static let searchBarTrailingImageName = "line.horizontal.3.decrease"
        static let searchText = "Search..."
        static let currentCoutOfFurnitureText = "0"
        static let dollarText = "$"
    }

    // MARK: - Public properties

    var body: some View {
        NavigationView {
            contentView
            .padding(.top)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [Color.yellow, Color.red], startPoint: .leading, endPoint: .trailing))
        }
    }

    // MARK: - Private properties
    
    private let columns = [GridItem()]

    @StateObject private var viewModel = ShopScreenViewModel()

    private var contentView: some View {
        ZStack {
            VStack {
                searchView
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 47, trailing: 0))
                ScrollView {
                    furnitureAssortmentGridView
                }
            }
            Text("\(Int(viewModel.totalCost))\(Constants.dollarText)")
                .modifier(TotalCostTextModifier())
        }
    }

    private var searchBarLeadingImageView: some View {
        Image(systemName: Constants.searchBarLeadingImageName)
            .resizable()
            .modifier(SearchBarImageModifier())
    }

    private var searchBarTrailingView: some View {
        Image(systemName: Constants.searchBarTrailingImageName)
            .resizable()
            .modifier(SearchBarImageModifier())
    }

    private var searchBurNavLinkView: some View {
        NavigationLink {
            FiltersScreenView()
        } label: {
            searchBarTrailingView
        }
        .padding(.trailing)
    }

    private var searchView: some View {
        HStack {
            searchBarLeadingImageView
            Text(Constants.searchText)
                .bold()
                .foregroundColor(.purple)
            Spacer()
            searchBurNavLinkView
        }
        .modifier(SearchBarModifier())
    }

    private var furnitureAssortmentGridView: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach((0..<FurnitureAssortment.furnitures.count)) {
                makeFurnitureItemView(furniture: FurnitureAssortment.furnitures[$0])
            }
        }
        .background(Color.white)
    }

    private var currentCountOfFurnitureView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .shadow(radius: 3)
                .padding()
            Text(Constants.currentCoutOfFurnitureText)
                .font(.title2)
                .scaledToFit()
                .bold()
        }
    }

    // MARK: - Private methods

    private func makeFurnitureImageView(_ imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 90,height: 90)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }

    private func makeDecrementButtonsView(furniture: Furniture) -> some View {
        Button {
            self.viewModel.decrementTotalCost(cost: furniture.cost)
        } label: {
            Image(systemName: Constants.minusImageName)
                .foregroundColor(.black)
                .bold()
        }
    }

    private func makeIncrementButtonsView(furniture: Furniture) -> some View {
        Button {
            self.viewModel.incrementTotalCost(cost: furniture.cost)
        } label: {
            Image(systemName: Constants.plusImageName)
                .foregroundColor(.black)
                .bold()
        }
    }

    private func makeNumberOfFurnitureView(furniture: Furniture) -> some View {
        VStack(spacing: 0) {
            Text("\(furniture.name)")
                .font(.title2)
                .bold()
            HStack(spacing: 0) {
                makeDecrementButtonsView(furniture: furniture)
                currentCountOfFurnitureView
                makeIncrementButtonsView(furniture: furniture)
            }
        }
        .frame(width: 90,height: 90)
    }

    private func makeCostLimitsView(furniture: Furniture) -> some View {
        VStack(spacing: 10) {
            Text("\(Constants.dollarText)\(Int(furniture.cost))")
                .font(Font.system(size: 25, design: .default))
                .foregroundColor(.gray.opacity(0.4))
                .strikethrough(true, color: .gray.opacity(0.4))
            Text("\(Constants.dollarText)\(Int(furniture.cost * furniture.discount))")
                .font(Font.system(size: 30, design: .default))
                .bold()
                .foregroundColor(.purple)
        }
        .frame(width: 110,height: 110)
    }

    private func makeFurnitureItemView(furniture: Furniture) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .shadow(radius: 10)
                .opacity(0.4)
                .padding()
            HStack {
                makeFurnitureImageView(furniture.imageName)
                makeNumberOfFurnitureView(furniture: furniture)
                makeCostLimitsView(furniture: furniture)
            }

        }
        .padding([.leading, .trailing])
        .frame(height: 150)
        .background(Color.white)
    }
}
