//
// OrbitronFont.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/27/25 at 11:25 AM
//

import SwiftUI

enum FontSize: CGFloat {
  case small = 20
  case regular = 25
  case large = 30
}


extension Font {
  static let orbitron: Font = .orbitron(size: .regular)

  static func orbitron(size: FontSize) -> Font {
    .custom("Orbitron", size: size.rawValue)
  }
}
