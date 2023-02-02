//  StartedView.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
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

    // MARK: - Public properties

    @StateObject var startedScreenViewModel = StartedScreenViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundView
                fakeLoader
                if startedScreenViewModel.isFakeLoadingComplete {
//                    ProfileScreenView().transition(.slide)
                }
            }
        }
    }

    // MARK: - Private properties

    private var backgroundView: some View {
        VStack(spacing: Constants.backGroundViewSpacing) {
            headLabelTextView.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        startedScreenViewModel.showHeadText()
                    }
                }
            }
            headLabelAsyncImageView
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            startedScreenViewModel.showGetStartedButton()
                        }
                    }
                }
            getStartedButtonView
            if startedScreenViewModel.isDeveloperAlertShown {
                developerAlert
            }
            singInTextView.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        startedScreenViewModel.showSingHereText()
                        startedScreenViewModel.startTimer()
                    }
                }
            }
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
            .scaleEffect(self.startedScreenViewModel.isHeadTextShown ? 1 : 0)
    }

    private var headLabelAsyncImageView: some View {
        AsyncImage(url: URL(string: Constants.furnitureURLs.randomElement() ?? Constants.emptyString))
            .scaleEffect(x:Constants.imageScaleCoef, y: Constants.imageScaleCoef)
            .padding(EdgeInsets(top: Constants.defaultOffsetValue, leading: Constants.defaultOffsetValue, bottom: Constants.asyncImageBottomOffset, trailing: Constants.defaultOffsetValue))
    }

    @GestureState var isDetectingLongPress = false
    @State var completedLongPress = false

    private var longGesture: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
                transaction.animation = Animation.easeIn(duration: 2.0)
            }
            .onEnded { finished in
                self.completedLongPress = finished
                self.startedScreenViewModel.isDeveloperAlertShown = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.startedScreenViewModel.isDeveloperAlertShown = false
                }
            }
    }

    private var getStartedButtonView: some View {
        NavigationLink(Constants.getStartedButtonTextLabel.uppercased(), destination: DescriptionView())
            .frame(width: Constants.getStartedButtonWidth, height: Constants.getStartedButtonHeight)
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .background(LinearGradient(colors: [.purple, .orange], startPoint: .bottom, endPoint: .top))
            .cornerRadius(Constants.getStartedButtonCornerRadius)
            .scaleEffect(startedScreenViewModel.isGetStartedButtonShow ? 1 : 0)
            .gesture(longGesture)
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
                .scaleEffect(startedScreenViewModel.isSingHereShow ? 1 : 0)
        }
    }

    private var fakeLoader: some View {
        Circle()
            .trim(from: 0, to: CGFloat(startedScreenViewModel.fakeLoaderAmount))
            .stroke(
                LinearGradient(colors: [Color("EndColor"), Color("EndColor"), Color("StartColor")], startPoint: .top, endPoint: .bottom),
                lineWidth: 30
            )
            .shadow(color: Color("EndColor"), radius: 10, x: 0, y: 0)
            .shadow(color: Color("StartColor"), radius: 10, x: 0, y: 0)
            .rotationEffect(Angle(degrees: 90))
            .frame(width: 150, height: 150)
    }

    private var developerAlert: some View {
        VStack {
            Text("A.Grogprenko!")
                .padding(.all, 15)
        }
        .background(Color.gray)
        .cornerRadius(15)
    }
}
