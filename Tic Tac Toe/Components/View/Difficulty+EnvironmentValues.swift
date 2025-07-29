//
// Difficulty+EnvironmentValues.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/22/25 at 5:50 PM
//

import SwiftUI

extension EnvironmentValues {
  @Entry var difficulty = ComputerLogic.Difficulty.normal
}


extension View {
  func selectedDifficulty(_ difficulty: ComputerLogic.Difficulty) -> some View {
    environment(\.difficulty, difficulty)
  }
}


extension Scene {
  func selectedDifficulty(_ difficulty: ComputerLogic.Difficulty) -> some Scene {
    environment(\.difficulty, difficulty)
  }
}
