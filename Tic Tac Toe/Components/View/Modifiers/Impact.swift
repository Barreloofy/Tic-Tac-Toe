//
// Impact.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 1:11 PM
//

import SwiftUI

struct Impact: ButtonStyle {
  @Environment(\.colorScheme) private var colorScheme

  let rotation: Angle

  private let offset = 8.0

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      RoundedRectangle()
        .fill(colorScheme.secondary)
        .offset(y: offset)

      RoundedRectangle()
        .fill(colorScheme.foreground)
        .offset(y: configuration.isPressed ? offset : 0)

      configuration.label
        .foregroundStyle(colorScheme.background)
        .padding(4)
        .offset(y: configuration.isPressed ? offset : 0)
    }
    .rotationEffect(rotation)
    .sensoryFeedback(
      .impact,
      trigger: configuration.isPressed)
    { _, _ in configuration.isPressed }
  }
}


extension ButtonStyle where Self == Impact {
  static func impact(rotationEffect: Angle) -> Self {
    Impact(rotation: rotationEffect)
  }
}


#Preview {
  Button("Press, me") {}
    .buttonStyle(.impact(rotationEffect: .rightRotation))
    .fixedSize()
    .configureApp()
}
