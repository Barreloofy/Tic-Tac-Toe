//
// Home.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/13/25 at 6:58 PM
//

import SwiftUI

struct Home: View {
  @Environment(\.colorScheme) private var colorScheme

  @State private var navigator = Navigator()
  @State private var presentDifficulty = false
  @State private var board = Cells()

  var body: some View {
    NavigationStack(path: $navigator.path) {
      VStack(spacing: 24) {
        Text("Tic Tac Toe")
          .prominent(rotation: .leftRotation)

        BoardView(board: board)
          .resultBoardPadding()

        VStack(spacing: 34) {
          NavigationLink("VS Player", value: false)
            .buttonStyle(.impact(rotationEffect: .rightRotation))

          NavigationLink("VS Computer", value: true)
            .buttonStyle(.impact(rotationEffect: .leftRotation))
        }
        .fixedSize()

        Button("Difficulty") { presentDifficulty = true }
          .buttonStyle(.plain)
          .sheet(isPresented: $presentDifficulty) {
            Difficulty()
              .presentationBackground(colorScheme.background)
              .presentationDetents([.fraction(0.10)])
              .dynamicTypeSize(.large)
          }

        Spacer()
      }
      .configureBackground()
      .navigationDestination(for: Bool.self) { vsComputer in
        GameView(vsComputer: vsComputer)
      }
      .onAppear { board = ComputerLogic.makeBoard() }
    }
    .environment(navigator)
  }
}
