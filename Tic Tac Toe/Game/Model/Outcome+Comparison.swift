//
// Outcome+Comparison.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/1/25 at 10:10 PM
//

extension Optional where Wrapped == GameLogic.Outcome {
  static func == (lhs: GameLogic.Outcome?, rhs: Player?) -> Bool {
    switch lhs {
    case .xWon: rhs == .x
    case .oWon: rhs == .o
    case .tie: false
    case .none: rhs == nil
    }
  }

  static func == (lhs: Player?, rhs: GameLogic.Outcome?) -> Bool {
    switch lhs {
    case .x: rhs == .xWon
    case .o: rhs == .oWon
    case .none: rhs == nil
    }
  }

  static func != (lhs: GameLogic.Outcome?, rhs: Player?) -> Bool {
    switch lhs {
    case .xWon: rhs != .x
    case .oWon: rhs != .o
    case .tie: true
    case .none: rhs != nil
    }
  }

  static func != (lhs: Player?, rhs: GameLogic.Outcome?) -> Bool {
    switch lhs {
    case .x: rhs != .xWon
    case .o: rhs != .oWon
    case .none: rhs != nil
    }
  }
}
