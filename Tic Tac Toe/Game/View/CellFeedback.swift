//
// CellFeedback.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 7:31 PM
//

import SwiftUI
import Odio

struct CellFeedback: ViewModifier {
  @State private var scale = 1.0

  let value: Game.Player?

  func body(content: Content) -> some View {
    content
      .scaleEffect(scale)
      .sensoryFeedback(.impact, trigger: value)
      .audioFeedback(.cellTap, trigger: value)
      .onChange(of: value) {
        withAnimation(
          .spring.speed(2),
          { scale = 1.05 },
          completion: { scale = 1.0 })
      }
  }
}


extension View {
  func cellFeedback(for cell: Cell) -> some View {
    modifier(CellFeedback(value: cell.value))
  }
}
