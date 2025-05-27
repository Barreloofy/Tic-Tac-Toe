//
// CellFeedback.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 7:31 PM
//

import SwiftUI

struct CellFeedback: ViewModifier {
  @State private var scale = 1.0
  @State private var shouldPlay = false

  let value: Game.Player?

  func body(content: Content) -> some View {
    content
      .scaleEffect(scale)
      .sensoryFeedback(.impact, trigger: scale)
      .sound("CellTap.mp3", isPlaying: shouldPlay)
      .onChange(of: value) {
        withAnimation(.spring) {
          scale = 1.05
          shouldPlay = true
        } completion: {
          scale = 1.0
          shouldPlay = false
        }
      }
  }
}


extension View {
  func cellFeedback(_ value: Game.Player?) -> some View {
    modifier(CellFeedback(value: value))
  }
}
