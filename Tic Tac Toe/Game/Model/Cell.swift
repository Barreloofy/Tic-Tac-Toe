//
// Cell.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 4:01 PM
//

import Foundation

@Observable
class Cell: Identifiable, CustomStringConvertible {
  let id = UUID()
  var value: Game.Player?

  var description: String {
    value?.rawValue ?? ""
  }
}
typealias Cells = [Cell]


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

  static func != (lhs: Cell, rhs: Cell) -> Bool {
    lhs.value != rhs.value
  }

  static func != (lhs: Cell, rhs: Game.Player?) -> Bool {
    lhs.value != rhs
  }

  static func != (lhs: Game.Player?, rhs: Cell) -> Bool {
    lhs != rhs.value
  }
}


extension Cell: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
}


extension Cells {
  static func initializeBoard() -> Cells {
    (1...9).map { _ in Cell() }
  }
}
