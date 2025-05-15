//
// Cell.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/15/25 at 4:01 PM
//

import Foundation

struct Cell: Identifiable {
  enum State: String {
    case empty = ""
    case x, o
  }

  var state = State.empty
  let id = UUID()
}
