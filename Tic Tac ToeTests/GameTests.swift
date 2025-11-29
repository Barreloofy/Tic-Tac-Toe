//
// GameTests.swift
// Tic Tac Toe
//
// Created by Barreloofy on 8/3/25 at 12:06 AM
//

import Testing
@testable import Tic_Tac_Toe

struct GameTests {
  @Suite("Validate the makeMove(_:) method of Game")
  struct MakeMoveTests {
    var game = Game()
    let initialPlayer: Player

    init() {
      self.initialPlayer = game.currentPlayer
    }

    @Test("Make valid move updates cell and switches player")
    mutating func validMove() async throws {
      // Arrange
      let cell = Cell()

      // Act
      game.makeMove(at: cell)

      // Assert
      #expect(cell == initialPlayer)
      #expect(game.currentPlayer != initialPlayer)
    }

    @Test("Make move on occupied cell, expect no change")
    mutating func invalidMove() async throws {
      // Arrange
      let cell = Cell()
      cell.value = .x

      // Act
      game.makeMove(at: cell)

      // Assert
      #expect(cell == .x)
      #expect(game.currentPlayer == initialPlayer)
    }
  }
}
