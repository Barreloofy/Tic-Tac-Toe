//
// ComputerLogic.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:30 PM
//

enum ComputerLogic {
  static func miniMax(game: GameState, depth: Int, isMaximizingPlayer: Bool) -> Int {
    if let result = GameLogic.gameOver(for: game) {
      switch result {
      case .xWon:
        return game.computerPlayer == .x ? 1 : -1
      case .oWon:
        return game.computerPlayer == .o ? 1 : -1
      case .tie:
        return 0
      }
    }


    if isMaximizingPlayer {
      var bestScore = Int.min

      game.board.filter { $0 == nil }.forEach { cell in
        cell.state = game.computerPlayer

        let score = miniMax(game: game, depth: depth + 1, isMaximizingPlayer: false)

        cell.state = nil

        bestScore = max(bestScore, score)
      }

      return bestScore
    } else {
      var bestScore = Int.max

      game.board.filter { $0 == nil }.forEach { cell in
        cell.state = !game.computerPlayer

        let score = miniMax(game: game, depth: depth + 1, isMaximizingPlayer: true)

        cell.state = nil

        bestScore = min(bestScore, score)
      }

      return bestScore
    }
  }

  static func getBestMove(game: GameState) -> Int {
    var bestScore = Int.min
    var bestMove = 0

    game.board.enumerated().filter { $0.element == nil }.forEach { index, cell in
      cell.state = game.computerPlayer

      let score = miniMax(game: game, depth: 0, isMaximizingPlayer: false)

      cell.state = nil

      if score > bestScore {
        bestScore = score
        bestMove = index
      }
    }

    return bestMove
  }
}
