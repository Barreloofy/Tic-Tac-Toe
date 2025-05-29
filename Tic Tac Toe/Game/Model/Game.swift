//
// GameState.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 11:52 AM
//

import Foundation

struct Game {
  enum Player: String, CaseIterable {
    case x, o

    static func random() -> Player {
      allCases.randomElement()!
    }
  }

  static func initiate(_ vsComputer: Bool) -> Game {
    vsComputer ? Game(computerPlayer: .random()) : Game()
  }

  mutating func initiate(_ vsComputer: Bool) {
    guard vsComputer && computerPlayer == nil else { return }
    computerPlayer = .random()
  }

  var currentPlayer = Player.random()
  var computerPlayer: Player?
  var isComputerMove: Bool { currentPlayer == computerPlayer }
  var turnDescription: String {
    isComputerMove ? "Computer's turn" : "Player \(currentPlayer.rawValue.uppercased())'s turn"
  }

  var board = (1...9).map { _ in Cell() }
  var result: GameLogic.Outcome?

  mutating func makeMove(_ cell: Cell) {
    guard cell == nil else { return }

    cell.value = currentPlayer

    currentPlayer = !currentPlayer
  }
}
