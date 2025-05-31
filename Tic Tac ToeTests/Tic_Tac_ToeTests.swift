//
// Tic_Tac_ToeTests.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/12/25 at 12:43 PM
//

import XCTest
@testable import Tic_Tac_Toe

final class Tic_Tac_ToeTests: XCTestCase {
  func testGameOver() {
    let board = (1...9).map { _ in Cell() }

    board[0].value = .x
    board[1].value = .x
    board[2].value = .o
    board[3].value = nil
    board[4].value = nil
    board[5].value = .o
    board[6].value = .o
    board[7].value = .x
    board[8].value = .o

    var gameState = Game()
    gameState.board = board

    XCTAssert(GameLogic.checkOutcome(for: gameState) != nil)
  }
}
