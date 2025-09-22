//
// SheetConfiguration.swift
// Tic Tac Toe
//
// Created by Barreloofy on 9/22/25 at 3:51 AM
//

import SwiftUI

struct SheetConfiguration: ViewModifier {
  @Environment(\.colorScheme) private var colorScheme

  func body(content: Content) -> some View {
    content
      .presentationBackground(colorScheme.background)
      .presentationCornerRadius(8)
      .presentationDetents([.fraction(0.10)])
      .dynamicTypeSize(.large)
  }
}


extension View {
  func configureSheet() -> some View {
    modifier(SheetConfiguration())
  }
}
