//
// GameLogicTest.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/22/25 at 10:21 AM
//

import Testing
@testable import Tic_Tac_Toe

struct GameLogicTests {
  @Suite("Integration validation for checkOutcome(for:)")
  struct TestCheckGame {
    var emptyGame: Game { Game() }

    var tieGame: Game {
      let game = Game()

      game.board[0].value = .o
      game.board[1].value = .x
      game.board[2].value = .o
      game.board[3].value = .o
      game.board[4].value = .x
      game.board[5].value = .x
      game.board[6].value = .x
      game.board[7].value = .o
      game.board[8].value = .o

      return game
    }

    var xWonGame: Game {
      let game = Game()

      game.board[2].value = .x
      game.board[5].value = .x
      game.board[8].value = .x

      return game
    }

    var oWonGame: Game {
      let game = Game()

      game.board[6].value = .o
      game.board[7].value = .o
      game.board[8].value = .o

      return game
    }

    @Test func validateCheckOutcome() async throws {
      #expect(GameLogic.checkOutcome(for: emptyGame) == nil)

      #expect(GameLogic.checkOutcome(for: tieGame) == .tie)

      #expect(GameLogic.checkOutcome(for: xWonGame) == .xWon)

      #expect(GameLogic.checkOutcome(for: oWonGame) == .oWon)
    }
  }


  struct TestCheckColumns {
    var emptyBoard: Cells { .initializeBoard() }

    var tieBoard: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .o
      board[1].value = .x
      board[2].value = .o
      board[3].value = .o
      board[4].value = .x
      board[5].value = .x
      board[6].value = .x
      board[7].value = .o
      board[8].value = .o

      return board
    }

    var oneColumnWithConsecutiveMarks: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .x
      board[3].value = .x
      board[6].value = .x

      return board
    }

    var multipleColumnsWithConsecutiveMarks: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .x
      board[3].value = .x
      board[6].value = .x

      board[1].value = .o
      board[4].value = .o
      board[7].value = .o

      return board
    }

    @Test func validateCheckColumns() async throws {
      #expect(GameLogic.checkColumns(for: emptyBoard) == nil)

      #expect(GameLogic.checkColumns(for: tieBoard) == nil)

      #expect(GameLogic.checkColumns(for: oneColumnWithConsecutiveMarks) == .xWon)

      #expect(GameLogic.checkColumns(for: multipleColumnsWithConsecutiveMarks) == .xWon)
    }
  }


  struct TestCheckRows {
    var emptyBoard: Cells { .initializeBoard() }

    var tieBoard: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .o
      board[1].value = .x
      board[2].value = .o
      board[3].value = .o
      board[4].value = .x
      board[5].value = .x
      board[6].value = .x
      board[7].value = .o
      board[8].value = .o

      return board
    }

    var oneRowWithConsecutiveMarks: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .x
      board[1].value = .x
      board[2].value = .x

      return board
    }

    var multipleRowsWithConsecutiveMarks: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .x
      board[1].value = .x
      board[2].value = .x

      board[3].value = .o
      board[4].value = .o
      board[5].value = .o

      return board
    }

    @Test func validateCheckRows() async throws {
      #expect(GameLogic.checkRows(for: emptyBoard) == nil)

      #expect(GameLogic.checkRows(for: tieBoard) == nil)

      #expect(GameLogic.checkRows(for: oneRowWithConsecutiveMarks) == .xWon)

      #expect(GameLogic.checkRows(for: multipleRowsWithConsecutiveMarks) == .xWon)
    }
  }


  struct TestCheckDiagonals {
    var emptyBoard: Cells { .initializeBoard() }

    var tieBoard: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .o
      board[1].value = .x
      board[2].value = .o
      board[3].value = .o
      board[4].value = .x
      board[5].value = .x
      board[6].value = .x
      board[7].value = .o
      board[8].value = .o

      return board
    }

    var oneDiagonalWithConsecutiveMarks: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .x
      board[4].value = .x
      board[8].value = .x

      return board
    }

    var overrideDiagonalWithConsecutiveMarks: Cells {
      let board: Cells = .initializeBoard()

      board[0].value = .x
      board[4].value = .x
      board[8].value = .x

      board[2].value = .o
      board[4].value = .o
      board[6].value = .o

      return board
    }

    @Test func validateCheckDiagonals() async throws {
      #expect(GameLogic.checkDiagonals(for: emptyBoard) == nil)

      #expect(GameLogic.checkDiagonals(for: tieBoard) == nil)

      #expect(GameLogic.checkDiagonals(for: oneDiagonalWithConsecutiveMarks) == .xWon)

      #expect(GameLogic.checkDiagonals(for: overrideDiagonalWithConsecutiveMarks) == .oWon)
    }
  }
}
