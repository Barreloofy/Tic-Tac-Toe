//
// CellAnimation.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 7:31 PM
//

import SwiftUI

struct CellAnimation: ViewModifier {
  @State private var scale = 1.0

  let state: Cell.State

  func body(content: Content) -> some View {
    content
      .onTapGesture {
        guard state == .empty else { return }
        withAnimation(.spring) {
          scale = 1.05
        } completion: {
          scale = 1.0
        }
      }
      .scaleEffect(scale)
      .sensoryFeedback(.impact, trigger: scale)
  }
}


extension View {
  func cellAnimation(state: Cell.State) -> some View {
    modifier(CellAnimation(state: state))
  }
}
