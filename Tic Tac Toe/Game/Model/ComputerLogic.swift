//
// ComputerLogic.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:30 PM
//

enum ComputerLogic {
  enum Difficulty: String, CaseIterable {
    case normal, hard, extreme

    var depthLimit: Int {
      switch self {
      case .normal: 3
      case .hard: 5
      case .extreme: .max
      }
    }
  }

  /// MiniMax algorithm with Alpha–beta pruning and depth limit.
  static func miniMax(
    game: Game,
    depth: Int,
    alpha: Int,
    beta: Int ,
    isMaximizingPlayer: Bool,
    difficulty: Difficulty)
  -> Int {
    switch GameLogic.checkOutcome(for: game) {
    case .xWon: return game.computerPlayer == .x ? (10 - depth) : (-10 + depth)
    case .oWon: return game.computerPlayer == .o ? (10 - depth) : (-10 + depth)
    case .tie: return 0
    default: break
    }

    guard depth < difficulty.depthLimit else { return 0 }

    var alpha = alpha
    var beta = beta

    if isMaximizingPlayer {
      var bestScore = Int.min

      for cell in game.board where cell == nil {
        cell.value = game.computerPlayer
        let score = miniMax(
          game: game,
          depth: depth + 1,
          alpha: alpha,
          beta: beta,
          isMaximizingPlayer: false,
          difficulty: difficulty)
        cell.value = nil

        bestScore = max(bestScore, score)
        alpha = max(alpha, score)
        if beta <= alpha { break }
      }

      return bestScore
    } else {
      var bestScore = Int.max

      for cell in game.board where cell == nil {
        cell.value = !game.computerPlayer
        let score = miniMax(
          game: game,
          depth: depth + 1,
          alpha: alpha,
          beta: beta,
          isMaximizingPlayer: true,
          difficulty: difficulty)
        cell.value = nil

        bestScore = min(bestScore, score)
        beta = min(beta, score)
        if beta <= alpha { break }
      }

      return bestScore
    }
  }

  /// Returns the best move determined by miniMax(:Game, :Int, :Int, :Int, :Bool, :Difficulty) -> Int,
  /// used by the computer-player for each of its turns.
  static func makeBestMove(game: Game, difficulty: Difficulty) {
    var bestScore = Int.min
    var bestMoves = Cells()

    game.board.filter { $0 == nil }.forEach { cell in
      cell.value = game.computerPlayer
      let score = miniMax(
        game: game,
        depth: .zero,
        alpha: .min,
        beta: .max,
        isMaximizingPlayer: false,
        difficulty: difficulty)
      cell.value = nil

      if score > bestScore {
        bestScore = score
        bestMoves = [cell]
      } else if score == bestScore {
        bestMoves.append(cell)
      }
    }

    bestMoves.randomElement()?.value = game.computerPlayer
  }

  /// Creates a full game where each player is the computer, used for the home view.
  static func makeBoard() -> Cells {
    var game = Game(computerPlayer: .random())

    while GameLogic.checkOutcome(for: game) == nil {
      makeBestMove(game: game, difficulty: .normal)
      game.computerPlayer = !game.computerPlayer
    }

    return game.board
  }
}
