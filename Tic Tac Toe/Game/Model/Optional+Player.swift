//
// Optional+Player.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/21/25 at 4:49 PM
//

extension Optional where Self == GameState.Player? {
  static prefix func ! (value: GameState.Player?) -> GameState.Player? {
    switch value {
    case .x: .o
    case .o: .x
    default: nil
    }
  }
}
