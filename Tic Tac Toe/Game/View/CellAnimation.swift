//
// CellAnimation.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 7:31 PM
//

import SwiftUI

struct CellAnimation: ViewModifier {
  @State private var scale = 1.0

  let state: GameState.Player?

  func body(content: Content) -> some View {
    content
      .scaleEffect(scale)
      .sensoryFeedback(.impact, trigger: scale)
      .onChange(of: state) {
        withAnimation(.spring) {
          scale = 1.05
        } completion: {
          scale = 1.0
        }
      }
  }
}


extension View {
  func cellAnimation(state: GameState.Player?) -> some View {
    modifier(CellAnimation(state: state))
  }
}
