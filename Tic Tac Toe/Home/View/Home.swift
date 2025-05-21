//
// Home.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/13/25 at 6:58 PM
//

import SwiftUI

struct Home: View {
  @State private var board = Cells()

  private let columns = Array(repeating: GridItem(spacing: 5), count: 3)

  var body: some View {
    NavigationStack {
      VStack(spacing: 50) {
        Text("Tic Tac Toe")
          .prominent(size: 45)

        ZStack {
          GridShape()
            .stroke(.crewPurple, lineWidth: 5)
            .scaledToFit()

          LazyVGrid(columns: columns, spacing: 5) {
            ForEach(board) { cell in
              ZStack {
                RoundedRectangle(cornerRadius: 10)
                  .fill(.crewDarkGray)
                  .shadow(color: .white, radius: 5)
                  .scaledToFit()

                Text(cell.description)
                  .font(.custom("Orbitron", size: 30))
                  .textCase(.uppercase)
              }
              .padding()
            }
          }
        }
        .padding(.horizontal, 50)

        NavigationLink("VS Player") { Game(vsComputer: false) }
        .buttonStyle(Impact(rotationDegrees: 5))

        NavigationLink("VS Computer") { Game(vsComputer: true) }
        .buttonStyle(Impact(rotationDegrees: -5))

        Spacer()
      }
      .padding()
      .background(.crewDarkGray)
      .onAppear {
        var game = GameState()

        game.board[.random(in: (0..<9))].state = game.currentPlayer
        game.computerPlayer = .random()

        while GameLogic.gameOver(for: game) == nil {
          game.board[ComputerLogic.getBestMove(game: game)].state = game.computerPlayer
          game.computerPlayer = game.computerPlayer == .x ? .o : .x
        }

        board = game.board
      }
    }
  }
}
