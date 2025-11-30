//
// GameLogic.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/19/25 at 3:40 PM
//

/// An interface to determine the state of a game of Tic Tac Toe.
enum GameLogic {
  /// The type representing the outcome of a game of Tic Tac Toe.
  ///
  /// > Important:
  /// `Outcome` conforms to Equatable and has multiple comparison operator overloads,
  /// review the implementations before use.
  enum Outcome: String, Equatable {
    case xWon = "Player X Won"
    case oWon = "Player O Won"
    case tie = "Tie"
  }

  /// Determines if an outcome was reached and thus the game is over.
  ///
  /// > Important:
  /// This function behaves differently from calling `checkColumns(for:)`, `checkRows(for:)`, and `checkDiagonals(for:)` one by one.
  /// Due to mutual exclusivity, if all prior functions evaluate to nil, determining if a tie was reached
  /// or if the game is still ongoing becomes straightforward. This is different from checking for tie independently.
  /// That's also the reason behind having the `checkTie()` function private.
  static func checkOutcome(for game: Game) -> Outcome? {
    return checkColumns(for: game.board) ??
    checkRows(for: game.board) ??
    checkDiagonals(for: game.board) ??
    checkTie(for: game.board)
  }

  /// Checks each column for consecutive mark's of the same symbol, if present, returns the appropriate outcome else nil.
  static func checkColumns(for board: Cells) -> Outcome? {
    let columns = [0, 1, 2]

    for offset in columns where board[offset] != nil {
      guard
        board[offset] == board[offset + 3] &&
        board[offset] == board[offset + 6]
      else { continue }

      return board[offset].value == .x ? .xWon : .oWon
    }

    return nil
  }

  /// Checks each row for consecutive mark's of the same symbol, if present, returns the appropriate outcome else nil.
  static func checkRows(for board: Cells) -> Outcome? {
    let rows = [0, 3, 6]

    for offset in rows where board[offset] != nil {
      guard
        board[offset] == board[offset + 1] &&
        board[offset] == board[offset + 2]
      else { continue }

      return board[offset].value == .x ? .xWon : .oWon
    }

    return nil
  }

  /// Checks each diagonal for consecutive mark's of the same symbol, if present, returns the appropriate outcome else nil.
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

  /// Checks for empty cells, if all cells are occupied, returns '.tie' else nil.
  ///
  /// > Important:
  /// Calling this method before the other GameLogic methods or solely this one, may return a false value.
  /// Call this method as the last of the four GameLogic methods.
  static private func checkTie(for board: Cells) -> Outcome? {
    board.filter { $0 == nil }.isEmpty ? .tie : nil
  }
}
