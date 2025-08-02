//
// Impact.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 1:11 PM
//

import SwiftUI

struct Impact: ButtonStyle {
  @Environment(\.colorScheme) private var colorScheme

  let width: CGFloat
  let height: CGFloat
  let fontSize: FontSize
  let rotation: Angle

  private let offset = 8.0

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(colorScheme.secondary)
        .offset(y: offset)

      RoundedRectangle(cornerRadius: 8)
        .offset(y: configuration.isPressed ? offset : 0)

      configuration.label
        .foregroundStyle(colorScheme.background)
        .offset(y: configuration.isPressed ? offset : 0)
    }
    .font(.orbitron(size: fontSize))
    .frame(width: width, height: height)
    .rotationEffect(rotation)
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
    fontSize: FontSize = .small,
    rotation: Angle)
  -> Impact {
    Impact(
      width: width,
      height: height,
      fontSize: fontSize,
      rotation: rotation)
  }
}
