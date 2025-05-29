//
// Game+Logic.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/19/25 at 3:40 PM
//

// MARK: Discussion, a matrix insted of a one-dimensional array was consider, but for simplicity reasons not chosen






























































/*
static func gameOver(for game: Game) -> Outcome? {
  if let result = GameLogic.checkColumn(for: game.board) ??
     GameLogic.checkRows(for: game.board) ??
     GameLogic.checkDiagonals(for: game.board) {
    switch result {
    case .x: return .xWon
    case .o: return .oWon
    }
  } else if game.board.filter({ $0 == nil }).isEmpty {
    return .tie
  }

  return nil
}

extension Game {
  enum Outcome {
    case xWon, oWon, tie

    var description: String {
      switch self {
      case .xWon: "Player X Won"
      case .oWon: "Player O Won"
      case .tie: "Tie"
      }
    }
  }
}


extension Game {
  /// Provides functions to check a 3x3 grid for consecutive mark's of the same symbol in the vertical, horizontal, diagonal axes.
  enum Logic {
    /// Checks each column for consecutive mark's of the same symbol, if present returns the appropriate mark else ".none"
    static func checkColumn(for board: Cells) -> Game.Player? {
      let columns = [0, 1, 2]

      for offset in columns where board[offset] != nil {
        guard board[offset + 3] == board[offset + 6] &&
              board[offset] == board[offset + 6] else { continue }
        return board[offset].state
      }

      return nil
    }

    /// Checks each row for consecutive mark's of the same symbol, if present returns the appropriate mark else ".none"
    static func checkRows(for board: Cells) -> Game.Player? {
      let rows = [0, 3, 6]

      for offset in rows where board[offset] != nil {
        guard board[offset + 1] == board[offset + 2] &&
              board[offset] == board[offset + 2] else { continue }
        return board[offset].state
      }

      return nil
    }

    /// Checks each diagonal for consecutive mark's of the same symbol, if present returns the appropriate mark else ".none"
    static func checkDiagonals(for board: Cells) -> Game.Player? {
      if board[0] == board[4] &&
         board[0] == board[8] &&
         board[0] != nil {
        return board[0].state
      }

      if board[2] == board[4] &&
         board[2] == board[6] &&
         board[2] != nil {
        return board[2].state
      }

      return nil
    }
  }
}
*/
