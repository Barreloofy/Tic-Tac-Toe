//
// OrbitronFont.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/27/25 at 11:25 AM
//

import SwiftUI

enum FontSize: CGFloat {
  case verySmall = 20
  case small = 25
  case regular = 30
  case large = 35
}


extension Font {
  static var orbitron: Font { .custom("Orbitron", size: FontSize.regular.rawValue) }

  static func orbitron(size: FontSize) -> Font {
    .custom("Orbitron", size: size.rawValue)
  }

  static func orbitron(size: CGFloat) -> Font {
    .custom("Orbitron", size: size)
  }
}
