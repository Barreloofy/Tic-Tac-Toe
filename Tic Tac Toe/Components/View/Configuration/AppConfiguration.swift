//
// AppConfiguration.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/28/25 at 2:30 PM
//

import SwiftUI

struct AppConfiguration: ViewModifier {
  @Environment(\.colorScheme) private var colorScheme

  func body(content: Content) -> some View {
    content
      .font(.orbitron)
      .fontWeight(.bold)
      .foregroundStyle(colorScheme.foreground)
      .statusBarHidden()
      .dynamicTypeSize(.large)
      .accessibilityHidden(true)
  }
}


extension View {
  func configureApp() -> some View {
    modifier(AppConfiguration())
  }
}
