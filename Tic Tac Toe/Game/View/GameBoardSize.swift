//
// GameBoardSize.swift
// Tic Tac Toe
//
// Created by Barreloofy on 8/21/25 at 10:00 PM
//

import SwiftUI

struct GameBoardSize: ViewModifier {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  private let largeSizeThreshold = 1032.0
  private let largeSizeFraction = 0.4

  private let regularSizeFraction = 0.6
  private let compactSizeFraction = 0.85

  func body(content: Content) -> some View {
    content
      .containerRelativeFrame(.horizontal) { length, _ in
        if length > largeSizeThreshold {
          length * largeSizeFraction
        } else {
          length * (horizontalSizeClass == .regular ? regularSizeFraction : compactSizeFraction)
        }
      }
  }
}


extension Board {
  func gameBoardSize() -> some View {
    self
      .modifier(GameBoardSize())
  }
}
