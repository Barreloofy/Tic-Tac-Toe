//
// Game.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 11:52 AM
//

struct Game: Hashable {
  enum Player: String, CaseIterable {
    case x, o

    static func random() -> Player {
      allCases.randomElement()!
    }
  }

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

  mutating func makeMove(at cell: Cell?) {
    guard let cell = cell, cell == .none else { return }

    cell.value = currentPlayer

    currentPlayer = !currentPlayer
  }

  mutating func assess() {
    result = GameLogic.checkOutcome(for: self)
  }
}
