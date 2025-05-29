//
// Game+MiniMax.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:30 PM
//































































/*
enum ComputerLogic {
  enum Difficulty: String, CaseIterable {
    case normal, hard, extreme

    var limit: Int {
      switch self {
      case .normal: 3
      case .hard: 5
      case .extreme: .max
      }
    }
  }

  static func miniMax(
    game: Game,
    depth: Int,
    alpha: Int,
    beta: Int ,
    isMaximizingPlayer: Bool,
    difficulty: Difficulty)
  -> Int {


    game.hasEnded()


    switch GameLogic.gameOver(for: game) {
    case .xWon: return game.computerPlayer == .x ? (10 - depth) : (-10 + depth)
    case .oWon: return game.computerPlayer == .o ? (10 - depth) : (-10 + depth)
    case .tie: return 0
    default: break
    }

    guard depth < difficulty.limit else { return 0 }

    var alpha = alpha
    var beta = beta

    if isMaximizingPlayer {
      var bestScore = Int.min

      for cell in game.board where cell == nil {
        cell.state = game.computerPlayer
        let score = miniMax(
          game: game,
          depth: depth + 1,
          alpha: alpha,
          beta: beta,
          isMaximizingPlayer: false,
          difficulty: difficulty)
        cell.state = nil

        bestScore = max(bestScore, score)
        alpha = max(alpha, score)
        if beta <= alpha { break }
      }

      return bestScore
    } else {
      var bestScore = Int.max

      for cell in game.board where cell == nil {
        cell.state = !game.computerPlayer
        let score = miniMax(
          game: game,
          depth: depth + 1,
          alpha: alpha,
          beta: beta,
          isMaximizingPlayer: true,
          difficulty: difficulty)
        cell.state = nil

        bestScore = min(bestScore, score)
        beta = min(beta, score)
        if beta <= alpha { break }
      }

      return bestScore
    }
  }

  static func getBestMove(game: Game, difficulty: Difficulty) -> Int {
    var bestScore = Int.min
    var bestMoves = [Int]()

    game.board.enumerated().filter { $0.element == nil }.forEach { index, cell in
      cell.state = game.computerPlayer
      let score = miniMax(
        game: game,
        depth: 0,
        alpha: .min,
        beta: .max,
        isMaximizingPlayer: false,
        difficulty: difficulty)
      cell.state = nil

      if score > bestScore {
        bestScore = score
        bestMoves = [index]
      } else if score == bestScore {
        bestMoves.append(index)
      }
    }

    return bestMoves.randomElement()!
  }
}


extension ComputerLogic {
  static func makeBoard() -> Cells {
    var game = Game()

    game.board[.random(in: (0..<9))].state = game.currentPlayer
    game.computerPlayer = .random()

    while GameLogic.gameOver(for: game) == nil {
      game.board[ComputerLogic.getBestMove(game: game, difficulty: .hard)].state = game.computerPlayer
      game.computerPlayer = game.computerPlayer == .x ? .o : .x
    }

    return game.board
  }
}
*/


extension Game.Computer {
  static func makeBoard() -> Cells {
    var game = Game()

    game.board.array[.random(in: (0..<9))].value = game.currentPlayer
    game.computerPlayer = .random()

    while game.board.hasEnded() == nil {
      game.board.array[Game.Computer.makeBestMove(game: game, difficulty: .hard)].value = game.currentPlayer
      game.computerPlayer = game.computerPlayer == .x ? .o : .x
    }

    return game.board.array
  }
}
