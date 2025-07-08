//
// ResultBoardPadding.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/8/25 at 1:55 AM
//

import SwiftUI

struct ResultBoardPadding: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.horizontal, 50)
  }
}


extension View {
  func resultBoardPadding() -> some View {
    modifier(ResultBoardPadding())
  }
}
