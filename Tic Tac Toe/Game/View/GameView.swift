//
// GameView.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:37 PM
//

import SwiftUI

struct GameView: View {
  @Environment(\.difficulty) private var difficulty

  @State private var game = Game()

  let vsComputer: Bool

  var body: some View {
    VStack {
      Text(game.turnDescription)
        .prominent()
        .animation(
          .bouncy(duration: 0.25, extraBounce: 0.2),
          value: game.currentPlayer)

      ZStack {
        GridTicTacToe()

        LazyVGrid(columns: GridItem.widthThree, spacing: 5) {
          ForEach(game.board) { cell in
            CellView(cell: cell)
              .contentShape(Rectangle())
              .cellFeedback(for: cell)
              .onTapGesture { game.makeMove(cell) }
              .disabled(game.isComputerMove)
          }
        }
      }
      .padding()
      .offset(y: 25)

      Spacer()
    }
    .ticTacToeBackground()
    .navigationDestination(item: $game.result) { _ in
      Score(state: $game, vsComputer: vsComputer)
    }
    .task(id: game.currentPlayer) {
      game.result = GameLogic.checkOutcome(for: game)
      guard game.result == nil && game.isComputerMove else { return }

      try? await Task.sleep(for: .seconds(1))

      ComputerLogic.makeBestMove(game: game, difficulty: difficulty)
      game.currentPlayer = !game.currentPlayer
    }
    .onAppear { game.initiate(vsComputer) }
  }
}
