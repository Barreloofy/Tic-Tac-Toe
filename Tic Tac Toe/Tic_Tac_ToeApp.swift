//
// Tic_Tac_ToeApp.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/12/25 at 12:43 PM
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
  @AppStorage("difficulty") private var difficulty = ComputerLogic.Difficulty.normal

  var body: some Scene {
    WindowGroup {
      Home()
        .configureApp()
    }
    .selectedDifficulty(difficulty)
  }
}
