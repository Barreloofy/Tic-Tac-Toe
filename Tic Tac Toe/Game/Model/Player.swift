//
// Player.swift
// Tic Tac Toe
//
// Created by Barreloofy on 11/30/25 at 12:11 AM
//

/// The type representing a Player in a game of Tic Tac Toe.
///
/// > Important:
/// `Player` implements multiple operators overloads:
/// `!`, `==`, `!=` review the implementations before use.
enum Player: String, CaseIterable {
  case x = "X"
  case o = "O"

  /// Returns a random `Player` case.
  ///
  /// - Returns: A random `Player` case.
  static func random() -> Player {
    allCases.randomElement()!
  }
}
