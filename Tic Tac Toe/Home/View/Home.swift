//
// Home.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/13/25 at 6:58 PM
//

import SwiftUI

struct Home: View {

  var body: some View {
    NavigationStack {
      VStack(spacing: 50) {
        Text("Tic Tac Toe")
          .prominent(size: 45)

        Board(content: (1...9).map { _ in Cell() })
          .padding(.horizontal, 50)

        NavigationLink("VS Player") { Game() }
        .buttonStyle(Impact(rotationDegrees: 5))

        NavigationLink("VS Computer") { Game() }
        .buttonStyle(Impact(rotationDegrees: -5))

        Spacer()
      }
      .padding()
      .background(.crewDarkGray)
    }
  }
}
