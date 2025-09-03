//
// Difficulty.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/23/25 at 11:41 PM
//

import SwiftUI

struct Difficulty: View {
  @AppStorage("difficulty") private var difficulty = ComputerLogic.Difficulty.normal

  var body: some View {
    HStack {
      ForEach(ComputerLogic.Difficulty.allCases) { difficultyCase in
        Text(difficultyCase.rawValue)
          .font(.orbitron(size: .small))
          .textCase(.uppercase)
          .onTapGesture { difficulty = difficultyCase }
          .overlay(alignment: .bottom) {
            RoundedRectangle()
              .frame(height: difficultyCase == difficulty ? 2 : 0)
          }
      }
    }
  }
}
