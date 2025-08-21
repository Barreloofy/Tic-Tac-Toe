//
// TurnAnimation.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/7/25 at 7:39 PM
//

import SwiftUI

struct TurnAnimation<T: Equatable>: ViewModifier {
  @State private var offset = 0.0

  let value: T
  let enabled: Bool

  func body(content: Content) -> some View {
    switch enabled {
    case true:
      content
        .offset(x: offset)
        .onChange(of: value) {
          withAnimation(
            .impact,
            { offset = 5 },
            completion: { offset = 0 })
        }
    case false:
      content
    }
  }
}


extension View {
  func turnAnimation(trigger: some Equatable, enabled: Bool) -> some View {
    modifier(TurnAnimation(value: trigger, enabled: enabled))
  }
}
