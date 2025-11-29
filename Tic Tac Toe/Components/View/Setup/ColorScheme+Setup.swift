//
// ColorScheme+Setup.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/28/25 at 3:08 PM
//

import SwiftUI

extension ColorScheme {
  var foreground: Color { .constructionOrange }
  var background: Color { .smokyBlack }
  var secondary: Color { .darkOrange }
  var grid: Color { .neonPurple }
  var playerX: Color { .crewBlue }
  var playerO: Color { .crewGreen }

  /// Provides the appropriate color for the specified player.
  /// - Parameter player: The specified player.
  /// - Returns: The appropriate color.
  func playerColor(_ player: Player?) -> Color {
    player == nil ? background : player == .x ? playerX : playerO
  }
}
