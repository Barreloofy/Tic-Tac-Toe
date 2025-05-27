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

    board[0].state = .x
    board[1].state = .x
    board[2].state = .o
    board[3].state = nil
    board[4].state = nil
    board[5].state = .o
    board[6].state = .o
    board[7].state = .x
    board[8].state = .o

    var gameState = Game()
    gameState.board = board

    XCTAssert(GameLogic.gameOver(for: gameState) != nil)
  }
}
