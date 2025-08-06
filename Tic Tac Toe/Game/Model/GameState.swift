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

    static prefix func ! (value: Player) -> Player {
      value == .x ? .o : .x
    }

    static func random() -> Player {
      allCases.randomElement()!
    }
  }

  static func initiate(_ vsComputer: Bool) -> Game {
    vsComputer ? Game(computerPlayer: .random()) : Game()
  }

  var currentPlayer = Player.random()
  var computerPlayer: Player?
  var isComputerMove: Bool { computerPlayer == currentPlayer }

  var board = (1...9).map { _ in Cell() }
  var result: GameLogic.Outcome?

  mutating func initiate(_ vsComputer: Bool) {
    guard vsComputer else { return }

    computerPlayer = .random()
  }

  mutating func makeMove(_ cell: Cell) {
    guard cell == nil else { return }

    cell.state = currentPlayer == .x ? .x : .o

    switch currentPlayer {
    case .x: currentPlayer = .o
    case .o: currentPlayer = .x
    }
  }
}
