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
  let fontSize: CGFloat
  let rotationDegrees: Double

  private let offset = 8.0

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(.darkOrange)
        .offset(y: offset)

      RoundedRectangle(cornerRadius: 8)
        .offset(y: configuration.isPressed ? offset : 0)

      configuration.label
        .foregroundStyle(UIConstants.background)
        .offset(y: configuration.isPressed ? offset : 0)
    }
    .font(.orbitron(size: fontSize))
    .frame(width: width, height: height)
    .rotationEffect(.degrees(rotationDegrees))
    .sensoryFeedback(
      .impact,
      trigger: configuration.isPressed)
    { _, _ in configuration.isPressed }
  }
}


extension ButtonStyle where Self == Impact {
  static func impact(
    width: CGFloat = 200,
    height: CGFloat = 40,
    fontSize: CGFloat = UIConstants.fontSmall,
    rotationDegrees: Double)
  -> Impact {
    Impact(
      width: width,
      height: height,
      fontSize: fontSize,
      rotationDegrees: rotationDegrees)
  }
}
