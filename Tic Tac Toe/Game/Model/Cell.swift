//
// Cell.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 4:01 PM
//

import Foundation

typealias Cells = [Cell]
@Observable
class Cell: Identifiable {
  let id = UUID()
  var state: Game.Player?

  var description: String {
    state?.rawValue ?? ""
  }
}


extension Cell: Equatable {
  static func == (lhs: Cell, rhs: Cell) -> Bool {
    lhs.state == rhs.state
  }

  static func == (lhs: Cell, rhs: Game.Player?) -> Bool {
    lhs.state == rhs
  }

  static func == (lhs: Game.Player?, rhs: Cell) -> Bool {
    lhs == rhs.state
  }

  static func != (lhs: Cell, rhs: Game.Player?) -> Bool {
    lhs.state != rhs
  }

  static func != (lhs: Game.Player?, rhs: Cell) -> Bool {
    lhs != rhs.state
  }
}


extension Cell: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
