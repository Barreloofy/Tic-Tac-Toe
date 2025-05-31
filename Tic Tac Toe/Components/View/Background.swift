//
// background.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/31/25 at 3:36 PM
//

import SwiftUI

struct TicTacToeBackground: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding()
      .background(.smokyBlack)
      .navigationBarBackButtonHidden()
  }
}


extension View {
  func ticTacToeBackground() -> some View {
    modifier(TicTacToeBackground())
  }
}
