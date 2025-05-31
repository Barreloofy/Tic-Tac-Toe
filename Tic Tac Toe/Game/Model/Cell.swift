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
  var value: Game.Player?

  var description: String {
    value?.rawValue ?? ""
  }
}


extension Cell: Equatable {
  static func == (lhs: Cell, rhs: Cell) -> Bool {
    lhs.value == rhs.value
  }

  static func == (lhs: Cell, rhs: Game.Player?) -> Bool {
    lhs.value == rhs
  }

  static func == (lhs: Game.Player?, rhs: Cell) -> Bool {
    lhs == rhs.value
  }

  static func != (lhs: Cell, rhs: Game.Player?) -> Bool {
    lhs.value != rhs
  }

  static func != (lhs: Game.Player?, rhs: Cell) -> Bool {
    lhs != rhs.value
  }
}
