//
// GameState.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 11:52 AM
//

import Foundation

struct GameState {
  enum Player: String, CaseIterable {
    case x, o

    static func random() -> Player {
      allCases.randomElement()!
    }
  }

  var board = (1...9).map { _ in Cell() } {
    didSet {
      switch currentPlayer {
      case .x: currentPlayer = .o
      case .o: currentPlayer = .x
      }
    }
  }
  private(set) var currentPlayer = Player.random()

  func makeMove() -> Cell.State {
    currentPlayer == .x ? .x : .o
  }
}
