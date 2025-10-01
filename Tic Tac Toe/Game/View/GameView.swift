//
// GameView.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:37 PM
//

import SwiftUI

struct GameView: View {
  @Environment(\.difficulty) private var difficulty
  @Environment(Navigator.self) private var navigator

  @State private var game = Game()
  @State private var initializationComplete = false

  let vsComputer: Bool

  var body: some View {
    VStack(spacing: 50) {
      Text(game.turnDescription)
        .prominent(rotation: .leftRotation)
        .turnAnimation(
          trigger: game.currentPlayer,
          enabled: initializationComplete)

      BoardView(for: game.board) { cell in
        CellView(for: cell)
          .cellFeedback(for: cell)
          .onTapGesture { game.makeMove(at: cell) }
          .disabled(game.isComputerMove)
      }
      .gameBoardSize()

      Spacer()
    }
    .configureBackground()
    .onAppear {
      game.initiate(vsComputer)
      initializationComplete = true
    }
    .onDisappear {
      initializationComplete = false
    }
    .onChange(of: game.currentPlayer) {
      game.assess()

      guard game.result != nil else { return }

      navigator.push(game)
    }
    .task(id: game.currentPlayer) {
      guard game.result == nil && game.isComputerMove else { return }

      guard (try? await Task.sleep(for: .seconds(1))) != nil else { return }

      game.makeMove(at: ComputerLogic.bestMove(for: game, difficulty: difficulty))
    }
    .navigationDestination(for: Game.self) { game in Score(game: game) }
  }
}
