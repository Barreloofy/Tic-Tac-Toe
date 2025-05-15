//
// ImpactButtonStyle.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 1:11 PM
//

import SwiftUI

struct Impact: ButtonStyle {
  let width: CGFloat
  let height: CGFloat
  let rotationDegrees: Double
  let size: CGFloat

  private let yOffset = 5.0

  init(width: CGFloat = 250, height: CGFloat = 50, rotationDegrees: Double, size: CGFloat = 30) {
    self.width = width
    self.height = height
    self.rotationDegrees = rotationDegrees
    self.size = size
  }

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .offset(y: yOffset)
      RoundedRectangle(cornerRadius: 10)
        .fill(.crewDarkGray)
        .scaleEffect(1.01)
        .offset(y: configuration.isPressed ? yOffset : 0)
      configuration.label
        .offset(y: configuration.isPressed ? yOffset : 0)
    }
    .font(.custom("Orbitron", size: 30))
    .frame(width: width, height: height)
    .rotationEffect(.degrees(rotationDegrees))
    .sensoryFeedback(
      .impact,
      trigger: configuration.isPressed)
    { _, _ in configuration.isPressed }
  }
}
