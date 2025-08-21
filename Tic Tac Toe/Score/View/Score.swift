//
// Score.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/20/25 at 3:17 PM
//

import SwiftUI
import Odio

struct Score: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(Navigator.self) private var navigator

  @AudioPlayer(.score, after: 0.5) private var audioPlayer

  let game: Game
  let vsComputer: Bool

  var body: some View {
    VStack(spacing: 24) {
      Board(board: game.board)
        .resultBoardSize()

      Text(game.resultDescription)
        .prominent(rotation: .rightRotation)

      VStack(spacing: 34) {
        Button("Play again") { dismiss() }
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
