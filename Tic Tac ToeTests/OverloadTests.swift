//
// OverloadTests.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/23/25 at 10:07 AM
//

import Testing
@testable import Tic_Tac_Toe

struct OverloadTests {
  @Suite("Validate the '==' and '!=' operator overload for type-pair (Cell, Game.Player) and vice versa")
  struct TestCellOverload {
    @Test func validateEquality() async throws {
      // Arrange
      let cellXOne = Cell()
      let cellXTwo = Cell()
      let cellOOne = Cell()
      let cellOTwo = Cell()

      cellXOne.value = .x
      cellXTwo.value = .x
      cellOOne.value = .o
      cellOTwo.value = .o

      // Act & Assert
      #expect(cellXOne == cellXOne)
      #expect(cellXOne == cellXTwo)

      #expect(cellOOne == cellOOne)
      #expect(cellOOne == cellOTwo)
    }

    @Test func validateInequality() async throws {
      // Arrange
      let cellX = Cell()
      let cellO = Cell()

      cellX.value = .x
      cellO.value = .o

      // Act & Assert
      #expect(cellX != cellO)
      #expect(cellO != cellX)
    }
  }


  @Suite("Validate the '==' and '!=' operator overload for type-pair (GameLogic.Outcome, Game.Player) and vice versa")
  struct TestOutcomeOverload {
    @Test(
      "Validate '==' operator overload for type-pair (GameLogic.Outcome, Game.Player)",
      arguments: [
        (GameLogic.Outcome.xWon, Game.Player.x),
        (GameLogic.Outcome.oWon, Game.Player.o),
        (nil, nil),
      ])
    func validateOutcomeEquality(lhs: GameLogic.Outcome?, rhs: Game.Player?) async throws {
      #expect(lhs == rhs)
    }

    @Test(
      "Validate '!=' operator overload for type-pair (GameLogic.Outcome, Game.Player)",
      arguments: [
        (GameLogic.Outcome.xWon, Game.Player.o),
        (GameLogic.Outcome.oWon, Game.Player.x),
        (GameLogic.Outcome.tie, Game.Player.x),
        (GameLogic.Outcome.tie, Game.Player.o),
        (nil, Game.Player.x),
        (nil, Game.Player.o),
      ])
    func validateOutcomeInequality(lhs: GameLogic.Outcome?, rhs: Game.Player?) async throws {
      #expect(lhs != rhs)
    }

    @Test(
      "Validate '==' operator overload for type-pair (Game.Player, GameLogic.Outcome)",
      arguments: [
        (Game.Player.x, GameLogic.Outcome.xWon),
        (Game.Player.o, GameLogic.Outcome.oWon),
        (nil, nil),
      ])
    func validatePlayerEquality(lhs: Game.Player?, rhs: GameLogic.Outcome?) async throws {
      #expect(lhs == rhs)
    }

    @Test(
      "Validate '!=' operator overload for type-pair (Game.Player, GameLogic.Outcome)",
      arguments: [
        (Game.Player.x, GameLogic.Outcome.oWon),
        (Game.Player.o, GameLogic.Outcome.xWon),
        (Game.Player.x, GameLogic.Outcome.tie),
        (Game.Player.o, GameLogic.Outcome.tie),
        (nil, GameLogic.Outcome.xWon),
        (nil, GameLogic.Outcome.oWon),
        (nil, GameLogic.Outcome.tie),
      ])
    func validatePlayerInequality(lhs: Game.Player?, rhs: GameLogic.Outcome?) async throws {
      #expect(lhs != rhs)
    }
  }


  @Suite("Validate the '!' operator overload for type Game.Player")
  struct TestPlayerNegation {
    @Test(
      "Pairs of opposite values are passed in",
      arguments: [
        (Game.Player.x, Game.Player.o),
        (Game.Player.o, Game.Player.x),
      ])
    func validateNegationOperatorOnInequalityValues(lhs: Game.Player?, rhs: Game.Player?) async throws {
      #expect(!lhs == rhs, "Negation is applied to the left, thus equality is expected")
    }

    @Test(
      "Pairs of the same value are passed in",
      arguments: [
        (Game.Player.x, Game.Player.x),
        (Game.Player.o, Game.Player.o),
      ]) func validateNegationOperatorOnEqualityValues(lhs: Game.Player?, rhs: Game.Player?) async throws {
        #expect(!lhs != rhs, "Negation is applied to the left, thus inequality is expected")
    }

    @Test(
      "Pair of nil is passed in",
      arguments: [
        (Game.Player?.none, Game.Player?.none),
      ]) func validateNegationOperatorOnNil(lhs: Game.Player?, rhs: Game.Player?) async throws {
      #expect(!lhs == rhs, "Negating nil will return nil, thus equality is expected")
    }
  }
}
