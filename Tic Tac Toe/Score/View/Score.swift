//
// Score.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:17 PM
//

import SwiftUI
import Odio

struct Score: View {
  @Environment(Navigator.self) private var navigator

  @AudioPlayer(.score, after: 0.5) private var audioPlayer

  let game: Game

  var body: some View {
    VStack(spacing: 15) {
      BoardView(for: game.board)
        .resultBoardSize()

      Text(game.resultDescription)
        .prominent(rotation: .rightRotation)

      VStack(spacing: 15) {
        Button("Play again") { navigator.popLast() }
          .buttonStyle(.impact(rotationEffect: .leftRotation))

        Button("Home") { navigator.popToRoot() }
          .buttonStyle(.impact(rotationEffect: .rightRotation))
      }
      .fixedSize()

      Spacer()
    }
    .configureBackground()
    .onAppear { audioPlayer() }
    .hapticFeedback(.victoryFeedback) {
      game.result != .tie &&
      game.result != game.computerPlayer
    }
  }
}
