//
// ComputerLogic.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:30 PM
//

/// An interface to determine the computer's move.
enum ComputerLogic {
  enum Difficulty: String, Identifiable, CaseIterable {
    case normal, hard, extreme

    var id: Difficulty { self }

    /// The recursion depth limit represented as an `Int`, controls the recursion depth of Minimax.
    var depthLimit: Int {
      switch self {
      case .normal: 2
      case .hard: 4
      case .extreme: .max
      }
    }
  }

  static let winScore = 10
  static let loseScore = -10
  static let tieScore = 0

  /// Minimax algorithm with Alpha–beta pruning and depth limit.
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
  static func minimax(
    game: Game,
    difficulty: Difficulty,
    isMaximizingPlayer: Bool,
    depth: Int,
    alpha: Int,
    beta: Int)
  -> Int {
    switch GameLogic.checkOutcome(for: game) {
    case .xWon: return game.computerPlayer == .x ? (winScore - depth) : (loseScore + depth)
    case .oWon: return game.computerPlayer == .o ? (winScore - depth) : (loseScore + depth)
    case .tie: return tieScore
    default: break
    }

    guard depth < difficulty.depthLimit else { return tieScore }

    if isMaximizingPlayer {
      var alpha = alpha
      var bestScore = Int.min

      for cell in game.board where cell == nil {
        cell.value = game.computerPlayer
        let score = minimax(
          game: game,
          difficulty: difficulty,
          isMaximizingPlayer: false,
          depth: depth + 1,
          alpha: alpha,
          beta: beta)
        cell.value = nil

        bestScore = max(bestScore, score)

        if bestScore >= beta { break }
        alpha = max(bestScore, alpha)
      }

      return bestScore
    } else {
      var beta = beta
      var bestScore = Int.max

      for cell in game.board where cell == nil {
        cell.value = !game.computerPlayer
        let score = minimax(
          game: game,
          difficulty: difficulty,
          isMaximizingPlayer: true,
          depth: depth + 1,
          alpha: alpha,
          beta: beta)
        cell.value = nil

        bestScore = min(bestScore, score)

        if bestScore <= alpha { break }
        beta = min(bestScore, beta)
      }

      return bestScore
    }
  }

  /// Returns the best move determined by minimax,
  /// used by the computer-player for each of its turns.
  /// - Returns: The best possible move as a cell.
  static func bestMove(for game: Game, difficulty: Difficulty) -> Cell? {
    var bestScore = Int.min
    var bestMoves = Cells()

    game.board.filter { $0 == nil }.forEach { cell in
      cell.value = game.computerPlayer
      let score = minimax(
        game: game,
        difficulty: difficulty,
        isMaximizingPlayer: false,
        depth: .zero,
        alpha: .min,
        beta: .max)
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

  /// Simulates a Tic-Tac-Toe game with the computer playing both sides, alternating turns.
  /// - Returns: The final board state.
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
