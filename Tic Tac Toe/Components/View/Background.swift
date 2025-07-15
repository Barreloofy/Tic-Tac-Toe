//
// Background.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/31/25 at 3:36 PM
//

import SwiftUI

struct BackgroundConfiguration: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding()
      .background(UIConstants.background)
      .navigationBarBackButtonHidden()
  }
}


extension View {
  func backgroundConfiguration() -> some View {
    modifier(BackgroundConfiguration())
  }
}
