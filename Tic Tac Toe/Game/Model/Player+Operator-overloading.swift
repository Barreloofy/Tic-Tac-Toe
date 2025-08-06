//
// Player+Operator-overloading.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/21/25 at 4:49 PM
//

extension Game.Player {
  static prefix func ! (value: Game.Player) -> Game.Player {
    value == .x ? .o : .x
  }
}


extension Optional where Self == Game.Player? {
  static prefix func ! (value: Game.Player?) -> Game.Player? {
    switch value {
    case .x: .o
    case .o: .x
    default: nil
    }
  }
}
