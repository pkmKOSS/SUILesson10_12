//  ShakeEffect.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 02.02.2023.
//

import SwiftUI

 /// Shake Effect
 struct ShakeEffect: GeometryEffect {
     // MARK: - Public Properties

     var travelDistance: CGFloat = 10
     var numOfShake: CGFloat = 3
     var animatableData: CGFloat

     // MARK: - Public Methods

     func effectValue(size: CGSize) -> ProjectionTransform {
         ProjectionTransform(CGAffineTransform(
             translationX:
             travelDistance * sin(animatableData * .pi * numOfShake),
             y: 0
         ))
     }
 }
