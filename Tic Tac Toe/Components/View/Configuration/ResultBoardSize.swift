//
// ResultBoardSize.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/8/25 at 1:55 AM
//

import SwiftUI

struct ResultBoardSize: ViewModifier {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  private let largeSizeThreshold = 1032.0
  private let largeSizeFraction = 0.3

  private let regularSizeFraction = 0.5
  private let compactSizeFraction = 0.75

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
  func resultBoardSize() -> some View {
    self
      .modifier(ResultBoardSize())
  }
}
