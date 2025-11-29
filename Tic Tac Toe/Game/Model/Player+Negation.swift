//
// Player+Negation.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/21/25 at 4:49 PM
//

extension Player {
  static prefix func ! (player: Player) -> Player {
    player == .x ? .o : .x
  }
}


extension Optional where Wrapped == Player {
  static prefix func ! (player: Player?) -> Player? {
    switch player {
    case .x: .o
    case .o: .x
    case .none: nil
    }
  }
}
