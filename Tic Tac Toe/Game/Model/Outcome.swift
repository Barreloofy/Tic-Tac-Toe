//
// Outcome.swift
// Tic Tac Toe
//
// Created by Barreloofy on 11/30/25 at 1:12 PM
//

/// The type representing the outcome of a game of Tic Tac Toe.
  ///
  /// > Important:
  /// `Outcome` conforms to Equatable and has multiple comparison operator overloads,
  /// review the implementations before use.
  enum Outcome: String, Equatable {
    case xWon = "Player X Won"
    case oWon = "Player O Won"
    case tie = "Tie"
  }
