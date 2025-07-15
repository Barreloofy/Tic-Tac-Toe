//
// OrbitronFont.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/27/25 at 11:25 AM
//

import SwiftUI

extension Font {
  static var orbitron: Font { .custom("Orbitron", size: UIConstants.fontRegular) }

  static func orbitron(size: CGFloat = UIConstants.fontRegular) -> Font {
    .custom("Orbitron", size: size)
  }
}
