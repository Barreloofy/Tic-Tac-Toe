//
// BackgroundConfiguration.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/31/25 at 3:36 PM
//

import SwiftUI

struct BackgroundConfiguration: ViewModifier {
  @Environment(\.colorScheme) private var colorScheme

  func body(content: Content) -> some View {
    content
      .padding()
      .background(colorScheme.background)
      .navigationBarBackButtonHidden()
  }
}


extension View {
  func configureBackground() -> some View {
    modifier(BackgroundConfiguration())
  }
}
