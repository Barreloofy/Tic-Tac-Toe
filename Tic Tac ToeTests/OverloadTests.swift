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
        (Outcome.xWon, Player.x),
        (Outcome.oWon, Player.o),
        (nil, nil),
      ])
    func validateOutcomeEquality(lhs: Outcome?, rhs: Player?) async throws {
      #expect(lhs == rhs)
    }

    @Test(
      "Validate '!=' operator overload for type-pair (GameLogic.Outcome, Game.Player)",
      arguments: [
        (Outcome.xWon, Player.o),
        (Outcome.oWon, Player.x),
        (Outcome.tie, Player.x),
        (Outcome.tie, Player.o),
        (nil, Player.x),
        (nil, Player.o),
      ])
    func validateOutcomeInequality(lhs: Outcome?, rhs: Player?) async throws {
      #expect(lhs != rhs)
    }

    @Test(
      "Validate '==' operator overload for type-pair (Game.Player, GameLogic.Outcome)",
      arguments: [
        (Player.x, Outcome.xWon),
        (Player.o, Outcome.oWon),
        (nil, nil),
      ])
    func validatePlayerEquality(lhs: Player?, rhs: Outcome?) async throws {
      #expect(lhs == rhs)
    }

    @Test(
      "Validate '!=' operator overload for type-pair (Game.Player, GameLogic.Outcome)",
      arguments: [
        (Player.x, Outcome.oWon),
        (Player.o, Outcome.xWon),
        (Player.x, Outcome.tie),
        (Player.o, Outcome.tie),
        (nil, Outcome.xWon),
        (nil, Outcome.oWon),
        (nil, Outcome.tie),
      ])
    func validatePlayerInequality(lhs: Player?, rhs: Outcome?) async throws {
      #expect(lhs != rhs)
    }
  }


  @Suite("Validate the '!' operator overload for type Game.Player")
  struct TestPlayerNegation {
    @Test(
      "Pairs of opposite values are passed in",
      arguments: [
        (Player.x, Player.o),
        (Player.o, Player.x),
      ])
    func validateNegationOperatorOnInequalityValues(lhs: Player?, rhs: Player?) async throws {
      #expect(!lhs == rhs, "Negation is applied to the left, thus equality is expected")
    }

    @Test(
      "Pairs of the same value are passed in",
      arguments: [
        (Player.x, Player.x),
        (Player.o, Player.o),
      ]) func validateNegationOperatorOnEqualityValues(lhs: Player?, rhs: Player?) async throws {
        #expect(!lhs != rhs, "Negation is applied to the left, thus inequality is expected")
    }

    @Test(
      "Pair of nil is passed in",
      arguments: [
        (Player?.none, Player?.none),
      ]) func validateNegationOperatorOnNil(lhs: Player?, rhs: Player?) async throws {
      #expect(!lhs == rhs, "Negating nil will return nil, thus equality is expected")
    }
  }
}
