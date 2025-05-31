//
// Home.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/13/25 at 6:58 PM
//

import SwiftUI

struct Home: View {
  @State private var navigator = Navigator()
  @State private var presentDifficulty = false
  @State private var board = Cells()

  var body: some View {
    NavigationStack(path: $navigator.path) {
      VStack(spacing: 40) {
        Text("Tic Tac Toe")
          .prominent(size: 45)

        BoardView(board: board)

        NavigationLink("VS Player", value: false)
          .buttonStyle(Impact(rotationDegrees: 5))

        NavigationLink("VS Computer", value: true)
          .buttonStyle(Impact(rotationDegrees: -5))

        Button("Difficulty") { presentDifficulty = true }
          .prominent(size: 20, rotationDegrees: 5)
          .offset(y: 25)
          .sheet(isPresented: $presentDifficulty) {
            Difficulty()
              .presentationBackground(.smokyBlack)
              .presentationDetents([.fraction(0.10)])
          }

        Spacer()
      }
      .ticTacToeBackground()
      .navigationDestination(for: Bool.self) { vsComputer in
        GameView(vsComputer: vsComputer)
      }
      .onAppear { board = ComputerLogic.makeBoard() }
    }
    .environment(navigator)
  }
}
