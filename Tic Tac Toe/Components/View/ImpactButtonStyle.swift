//
// ImpactButtonStyle.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 1:11 PM
//

import SwiftUI

struct Impact: ButtonStyle {
  var width: CGFloat = 200
  var height: CGFloat = 40
  var size: CGFloat = 25
  let rotationDegrees: Double

  private let offset = 8.0

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .fill(.darkOrange)
        .offset(y: offset)

      RoundedRectangle(cornerRadius: 10)
        .offset(y: configuration.isPressed ? offset : 0)

      configuration.label
        .foregroundStyle(.smokyBlack)
        .offset(y: configuration.isPressed ? offset : 0)
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
