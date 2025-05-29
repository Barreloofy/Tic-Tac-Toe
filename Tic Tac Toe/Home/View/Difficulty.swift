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
      ForEach(ComputerLogic.Difficulty.allCases, id: \.self) { difficultyCase in
        Text(difficultyCase.rawValue)
          .font(.orbitron(20))
          .textCase(.uppercase)
          .onTapGesture { difficulty = difficultyCase }
          .overlay(alignment: .bottom) {
            if difficultyCase == difficulty {
              RoundedRectangle(cornerRadius: 10)
                .frame(height: 2)
            }
          }
      }
    }
  }
}
