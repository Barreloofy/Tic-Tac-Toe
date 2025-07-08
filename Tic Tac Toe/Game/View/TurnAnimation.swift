//
// TurnAnimation.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/7/25 at 7:39 PM
//

import SwiftUI

struct TurnAnimation<T: Equatable>: ViewModifier {
  @State private var offset: CGFloat = 0

  let value: T

  func body(content: Content) -> some View {
    content
      .offset(x: offset)
      .onChange(of: value) {
        withAnimation(.bouncy(duration: 0.2, extraBounce: 0.2)) {
          offset = 5
        } completion: {
          withAnimation(.bouncy(duration: 0.2)) {
            offset = 0
          }
        }
      }
  }
}


extension View {
  func turnAnimation<T: Equatable>(trigger: T) -> some View {
    modifier(TurnAnimation(value: trigger))
  }
}
