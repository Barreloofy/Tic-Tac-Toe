//
// GameLogic.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/19/25 at 3:40 PM
//

// MARK: Discussion, a matrix insted of a one-dimensional array was consider, but for simplicity reasons not chosen

/// Provides functions to check a 3x3 grid for consecutive mark's of the same symbol in the vertical, horizontal, diagonal axes.
/// Returns the symbol as a 'Outcome' enum case if a macth is found else '.none'
enum GameLogic {
  enum Outcome: String {
    case xWon = "Player X Won"
    case oWon = "Player O Won"
    case tie = "Tie"
  }

  static func checkGameOver(for game: Game) -> Outcome? {
    return GameLogic.checkColumn(for: game.board) ??
    GameLogic.checkRows(for: game.board) ??
    GameLogic.checkDiagonals(for: game.board) ??
    GameLogic.checkTie(for: game.board)
  }

  /// Checks each column for consecutive mark's of the same symbol, if present returns the appropriate mark else ".none"
  static func checkColumn(for board: Cells) -> Outcome? {
    let columns = [0, 1, 2]

    for offset in columns where board[offset] != nil {
      guard board[offset] == board[offset + 3] &&
            board[offset] == board[offset + 6] else { continue }
      return board[offset].value == .x ? .xWon : .oWon
    }

    return nil
  }

  /// Checks each row for consecutive mark's of the same symbol, if present returns the appropriate mark else ".none"
  static func checkRows(for board: Cells) -> Outcome? {
    let rows = [0, 3, 6]

    for offset in rows where board[offset] != nil {
      guard board[offset] == board[offset + 1] &&
            board[offset] == board[offset + 2] else { continue }
      return board[offset].value == .x ? .xWon : .oWon
    }

    return nil
  }

  /// Checks each diagonal for consecutive mark's of the same symbol, if present returns the appropriate mark else ".none"
  static func checkDiagonals(for board: Cells) -> Outcome? {
    if board[0] == board[4] &&
       board[0] == board[8] &&
       board[0] != nil {
      return board[0].value == .x ? .xWon : .oWon
    }

    if board[2] == board[4] &&
       board[2] == board[6] &&
       board[2] != nil {
      return board[2].value == .x ? .xWon : .oWon
    }

    return nil
  }

  static func checkTie(for board: Cells) -> Outcome? {
    board.filter { $0 == nil }.isEmpty ? .tie : nil
  }
}
