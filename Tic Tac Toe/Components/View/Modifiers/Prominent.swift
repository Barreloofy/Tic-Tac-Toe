//
// Prominent.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:51 PM
//

import SwiftUI

struct Prominent: ViewModifier {
  let rotation: Angle

  func body(content: Content) -> some View {
    content
      .font(.orbitron(size: .large))
      .rotationEffect(rotation)
  }
}


extension View {
  func prominent(rotation: Angle) -> some View {
    modifier(Prominent(rotation: rotation))
  }
}


#Preview {
  Text("Hello, World!")
    .configureApp()
}
