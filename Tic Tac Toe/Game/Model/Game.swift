//
// Game.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 11:52 AM
//

/// The type representing a game of Tic Tac Toe.
struct Game: Hashable {
  /// The type representing a Player in a game of Tic Tac Toe.
  ///
  /// > Important: `Player` has multiple different operator implementations for the following operators:
  /// `!`, `==`, `!=` review the implementations before use.
  enum Player: String, Equatable, CaseIterable {
    case x, o

    static func random() -> Player {
      allCases.randomElement()!
    }
  }

  /// Initializes a new instance of `Game` as a mutation of `self`.
  ///
  /// - Parameter vsComputer: Specify if the newly initialized instance is set for PvP or PvE.
  mutating func initiate(_ vsComputer: Bool) {
    self = Game(computerPlayer: vsComputer ? .random() : nil)
  }

  var currentPlayer = Player.random()
  var computerPlayer: Player?
  var isComputerMove: Bool { currentPlayer == computerPlayer }
  var turnDescription: String {
    isComputerMove ? "Computer's turn" : "Player \(currentPlayer.rawValue.uppercased())'s turn"
  }

  let board: Cells = .initializeBoard()
  var result: GameLogic.Outcome?
  var resultDescription: String { result?.rawValue ?? "" }

  /// Mutates the state of the `Game` instance.
  ///
  /// When the provided cell is not nil and empty,
  /// cell will be set to `currentPlayer`
  /// and `currentPlayer` will be set to the opposing player.
  ///
  /// - Parameter cell: The cell to set to `currentPlayer`.
  mutating func makeMove(at cell: Cell?) {
    guard let cell = cell, cell == .none else { return }

    cell.value = currentPlayer

    currentPlayer = !currentPlayer
  }

  /// Assesses the state of the `Game` instance.
  ///
  /// If an outcome can be determined, sets `result` to that outcome.
  mutating func assess() {
    result = GameLogic.checkOutcome(for: self)
  }
}
