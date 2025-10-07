//
// Player+Negation.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/21/25 at 4:49 PM
//

extension Game.Player {
  static prefix func ! (player: Game.Player) -> Game.Player {
    player == .x ? .o : .x
  }
}


extension Optional where Wrapped == Game.Player {
  static prefix func ! (player: Game.Player?) -> Game.Player? {
    switch player {
    case .x: .o
    case .o: .x
    case .none: nil
    }
  }
}
