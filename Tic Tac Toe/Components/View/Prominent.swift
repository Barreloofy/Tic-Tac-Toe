//
// Prominent.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:51 PM
//

import SwiftUI

struct Prominent: ViewModifier {
  let fontSize: FontSize
  let rotation: Angle

  func body(content: Content) -> some View {
    content
      .font(.orbitron(size: fontSize))
      .rotationEffect(rotation)
  }
}


extension View {
  func prominent(
    fontSize: FontSize = .large,
    rotation: Angle = .leftRotation)
  -> some View {
    modifier(Prominent(fontSize: fontSize, rotation: rotation))
  }
}
