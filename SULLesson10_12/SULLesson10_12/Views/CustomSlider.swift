//  CustomSlider.swift
//  SULLesson10_12
//
//  Created by Григоренко Александр Игоревич on 29.01.2023.
//

import SwiftUI

/// Кастомный слайдер, умеет изменять цвет бегунка.
struct SwiftUISlider: UIViewRepresentable {

    /// Координатор для работы со значением слайдера
    final class Coordinator: NSObject {

        // MARK: - private? properties

        var step: Float = 500

        var value: Binding<Double>

        // MARK: - Init

        init(value: Binding<Double>) {
            self.value = value
        }

        // MARK: - Public methods

        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(round(sender.value / step) * step)
        }
    }

    // MARK: - Public properties

    @Binding var value: Double

    var thumbColor: UIColor = .white
    var minTrackColor: UIColor?
    var maxTrackColor: UIColor?

    // MARK: - Public methods

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.maximumValue = 5000
        slider.minimumValue = 500
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor

        slider.value = Float(value)

        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )

        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(self.value)
    }

    func makeCoordinator() -> SwiftUISlider.Coordinator {
        Coordinator(value: $value)
    }
}
