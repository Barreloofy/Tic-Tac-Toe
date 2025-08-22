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
  @State private var initializationComplete = false

  let vsComputer: Bool

  var body: some View {
    VStack(spacing: 24) {
      Text(game.turnDescription)
        .prominent(rotation: .leftRotation)
        .turnAnimation(
          trigger: game.currentPlayer,
          enabled: initializationComplete)

      BoardView(for: game.board) { cell in
        CellView(for: cell)
          .cellFeedback(for: cell)
          .onTapGesture { game.makeMove(cell) }
          .disabled(game.isComputerMove)
      }
      .gameBoardSize()

      Spacer()
    }
    .configureBackground()
    .navigationDestination(item: $game.result) { _ in
      Score(game: game, vsComputer: vsComputer)
    }
    .onAppear {
      game.initiate(vsComputer)
      initializationComplete = true
    }
    .onDisappear { initializationComplete = false }
    .onChange(of: game.currentPlayer) { game.updateResult() }
    .task(id: game.currentPlayer) {
      guard game.result == nil && game.isComputerMove else { return }

      guard (try? await Task.sleep(for: .seconds(1))) != nil else { return }

      game.makeMove(ComputerLogic.bestMove(for: game, difficulty: difficulty))
    }
  }
}
