//
// ProminentTextStyle.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:51 PM
//

import SwiftUI

struct Prominent: ViewModifier {
  let fontSize: CGFloat
  let rotationDegrees: Double

  func body(content: Content) -> some View {
    content
      .font(.orbitron(size: fontSize))
      .rotationEffect(.degrees(rotationDegrees))
  }
}


extension View {
  func prominent(
    fontSize: CGFloat = UIConstants.fontLarge,
    rotationDegrees: Double = UIConstants.leftRotation)
  -> some View {
    modifier(Prominent(fontSize: fontSize, rotationDegrees: rotationDegrees))
  }
}
