//
// ComputerLogic.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:30 PM
//

enum ComputerLogic {
  enum Difficulty: String, CaseIterable, Identifiable {
    case normal, hard, extreme

    var id: Difficulty { self }

    /// The recursion depth limit represented as an int, controls the recursion depth of miniMax.
    var depthLimit: Int {
      switch self {
      case .normal: 3
      case .hard: 5
      case .extreme: .max
      }
    }
  }

  /// MiniMax algorithm with Alpha–beta pruning and depth limit.
  /// - Parameters:
  ///   - game: Instance of type 'Game' to use.
  ///   - depth: The current depth of recursion.
  ///   - alpha: The highest score that the maximizer can guarantee.
  ///   - beta: The lowest score that the minimizer can guarantee.
  ///   - isMaximizingPlayer: A boolean to control if its the maximizer or minimizer's turn.
  ///   - difficulty: The difficulty to use, which controls the recursion depth.
  /// - Returns:
  /// A score representing the value of the particular move,
  /// the higher the score the better the move for the maximizer and vice-versa.
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

  /// Returns the best move determined by miniMax(game:, depth:, alpha:, beta:, isMaximizingPlayer:, difficulty:) -> Int,
  /// used by the computer-player for each of its turns.
  /// - Returns: The best possible move as a cell.
  static func bestMove(for game: Game, difficulty: Difficulty) -> Cell? {
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

    return bestMoves.randomElement()
  }

  /// Creates a board, where the computer plays against itself in alteranting turns.
  /// - Returns: The board of a complete game of Tic-Tac-Toe.
  static func makeBoard() -> Cells {
    var game = Game(computerPlayer: .random())
    var bestCell: Cell?

    while GameLogic.checkOutcome(for: game) == nil {
      bestCell = bestMove(for: game, difficulty: .normal)

      bestCell?.value = game.computerPlayer

      game.computerPlayer = !game.computerPlayer
    }

    return game.board
  }
}
