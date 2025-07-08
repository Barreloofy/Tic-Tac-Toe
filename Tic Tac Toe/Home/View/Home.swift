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
      VStack(spacing: 50) {
        Text("Tic Tac Toe")
          .prominent()

        BoardView(board: board)
          .resultBoardPadding()

        NavigationLink("VS Player", value: false)
          .buttonStyle(.impact(rotationDegrees: 5))

        NavigationLink("VS Computer", value: true)
          .buttonStyle(.impact(rotationDegrees: -5))

        Button("Difficulty") { presentDifficulty = true }
          .buttonStyle(.impact(width: 125, height: 30, fontSize: 20, rotationDegrees: 5))
          .sheet(isPresented: $presentDifficulty) {
            Difficulty()
              .dynamicTypeSize(.large)
              .presentationBackground(.smokyBlack)
              .presentationDetents([.fraction(0.10)])
          }

        Spacer()
      }
      .backgroundConfiguration()
      .navigationDestination(for: Bool.self) { vsComputer in
        GameView(vsComputer: vsComputer)
      }
      .onAppear { board = ComputerLogic.makeBoard() }
    }
    .environment(navigator)
  }
}
