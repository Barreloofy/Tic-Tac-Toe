//
// ProminentTextStyle.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:51 PM
//

import SwiftUI

struct Prominent: ViewModifier {
  let size: CGFloat
  let rotationDegrees: Double

  func body(content: Content) -> some View {
    content
      .font(.custom("Orbitron", size: 35))
      .rotationEffect(.degrees(rotationDegrees))
  }
}


extension View {
  func prominent(
    size: CGFloat,
    rotationDegrees: Double = -5
  ) -> some View {
    modifier(Prominent(size: size, rotationDegrees: rotationDegrees))
  }
}
