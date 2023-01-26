//
//  StartedView.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 23.01.2023.
//

import SwiftUI

/// Стартовый экран
struct StartedView: View {
    
    // MARK: - Private constants
    
    private enum Constants {
        static let furnitureURLs = [
            "https://i.postimg.cc/nr6RgPGW/icons8-sofa-100.png",
            "https://i.postimg.cc/htSvCfTR/bedRoom.png",
            "https://i.postimg.cc/y8vd2syg/kreslo.png",
            "https://i.postimg.cc/mkLQMMCX/buffet.png",
            "https://i.postimg.cc/B6G5SR6G/icons8-coffee-table-100.png",
            "https://i.postimg.cc/MpNb4nJH/schkaf.png",
            "https://i.postimg.cc/W36GhSFq/stol.png"
        ]
        static let headLabelTextViewName = "Online furniture store"
        static let headLabelTextViewNameLineLimit = 2
        static let headLabelTextViewNameWidth: CGFloat = 270
        static let headLabelTextViewNameLineSpacing: CGFloat = 15
        static let backgroundViewColorOpacity: CGFloat = 0.4
        static let chair = "https://i.postimg.cc/s2W9R33c/stul.png"
        static let asyncImageBottomOffset: CGFloat = 130
        static let imageScaleCoef: CGFloat = 2
        static let defaultOffsetValue: CGFloat = 0
        static let getStartedButtonTextLabel = "Get started"
        static let getStartedButtonWidth: CGFloat = 250
        static let getStartedButtonHeight: CGFloat = 70
        static let getStartedButtonCornerRadius: CGFloat = 35
        static let singInTopTextName = "Don't have an account?"
        static let singInBottomTextName = "Sing in here"
        static let singInOverlayHeight: CGFloat = 1
        static let singInOverlayYOffset: CGFloat = 4
        static let singInTextWidht: CGFloat = 200
        static let singInTextLineSpacing: CGFloat = 15
        static let backGroundViewSpacing: CGFloat = 44
        static let emptyString = ""
    }
    
    // MARK: - public properties
    
    var body: some View {
        NavigationView {
            backgroundView
        }
    }
    
    // MARK: - private properties
    
    private var backgroundView: some View {
        VStack(spacing: Constants.backGroundViewSpacing) {
            headLabelTextView
            headLabelAsyncImageView
            getStartedButtonView
            singInTextView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color.orange, Color.yellow], startPoint: .bottom, endPoint: .top))
    }
    
    private var headLabelTextView: some View {
        Text(Constants.headLabelTextViewName.uppercased())
            .foregroundColor(.white)
            .fontWeight(.heavy)
            .lineLimit(Constants.headLabelTextViewNameLineLimit)
            .frame(width: Constants.headLabelTextViewNameWidth)
            .multilineTextAlignment(.center)
            .lineSpacing(Constants.headLabelTextViewNameLineSpacing)
            .font(.title)
    }
    
    private var headLabelAsyncImageView: some View {
        AsyncImage(url: URL(string: Constants.furnitureURLs.randomElement() ?? Constants.emptyString))
            .scaleEffect(x:Constants.imageScaleCoef, y: Constants.imageScaleCoef)
            .padding(EdgeInsets(top: Constants.defaultOffsetValue, leading: Constants.defaultOffsetValue, bottom: Constants.asyncImageBottomOffset, trailing: Constants.defaultOffsetValue))
    }
    
    private var getStartedButtonView: some View {
        NavigationLink(Constants.getStartedButtonTextLabel.uppercased(), destination: DescriptionView())
            .frame(width: Constants.getStartedButtonWidth, height: Constants.getStartedButtonHeight)
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .background(LinearGradient(colors: [.purple, .orange], startPoint: .bottom, endPoint: .top))
            .cornerRadius(Constants.getStartedButtonCornerRadius)
    }
    
    private var singInTextView: some View {
        VStack {
            Text(Constants.singInTopTextName)
                .foregroundColor(.white)
                .fontWeight(.bold)
            NavigationLink(Constants.singInBottomTextName, destination: AuthorizationView())
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.title).overlay(
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 150, height: Constants.singInOverlayHeight)
                        .offset(y: Constants.singInOverlayYOffset),
                    alignment: .bottom
                )
                .multilineTextAlignment(.center)
                .frame(width: Constants.singInTextWidht)
                .lineSpacing(Constants.singInTextLineSpacing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartedView()
    }
}
