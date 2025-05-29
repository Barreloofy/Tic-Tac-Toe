//
// ImpactButtonStyle.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 1:11 PM
//

import SwiftUI

struct Impact: ButtonStyle {
  var width: CGFloat = 250
  var height: CGFloat = 50
  var size: CGFloat = 30
  let rotationDegrees: Double

  private let yOffset = 5.0

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .offset(y: yOffset)
      RoundedRectangle(cornerRadius: 10)
        .fill(.smokyBlack)
        .scaleEffect(1.01) // Needed for AA fix, simplest way to achieve this without creating custom shape.
        .offset(y: configuration.isPressed ? yOffset : 0)
      configuration.label
        .offset(y: configuration.isPressed ? yOffset : 0)
    }
    .font(.orbitron(size))
    .frame(width: width, height: height)
    .rotationEffect(.degrees(rotationDegrees))
    .sensoryFeedback(
      .impact,
      trigger: configuration.isPressed)
    { _, _ in configuration.isPressed }
  }
}
