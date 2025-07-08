//
// Score.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:17 PM
//

import SwiftUI

struct Score: View {
  @Environment(Navigator.self) private var navigator

  @Binding var game: Game

  let vsComputer: Bool

  var body: some View {
    VStack(spacing: 50) {
      BoardView(board: game.board)
        .resultBoardPadding()

      Text(game.resultDescription)
        .prominent()

      Button("Play, again") { game.reset() }
        .buttonStyle(.impact(rotationDegrees: 5))

      Button("Home") { navigator.popToRoot() }
        .buttonStyle(.impact(rotationDegrees: -5))

      Spacer()
    }
    .backgroundConfiguration()
    .onAppear { AudioManager.session.play("Score.mp3") }
    .hapticFeedback(winFeedback()) {
      game.result != .tie &&
      game.computerPlayer == nil ||
      game.result != game.computerPlayer
    }
  }
}
