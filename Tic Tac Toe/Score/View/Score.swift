//
// Score.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:17 PM
//

import SwiftUI

struct Score: View {
  @Environment(Navigator.self) private var navigator

  @Binding var state: Game

  let vsComputer: Bool

  var body: some View {
    VStack(spacing: 40) {
      BoardView(board: state.board)

      Text(state.resultDescription)
        .prominent()

      Button("Play, again") { state = .initiate(vsComputer) }
        .buttonStyle(Impact(rotationDegrees: 5))

      Button("Home") { navigator.popToRoot() }
        .buttonStyle(Impact(rotationDegrees: -5))

      Spacer()
    }
    .ticTacToeBackground()
    .onAppear { AudioManager.session.play("Score.mp3") }
  }
}
