//
// GameView.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:37 PM
//

import SwiftUI

struct GameView: View {
  @Environment(\.difficulty) private var difficulty

  @State private var game = Game()

  let vsComputer: Bool

  private var player: String {
    game.isComputerMove ? "Computer's turn" : "Player \(game.currentPlayer.rawValue.uppercased())'s turn"
  }

  var body: some View {
    VStack(spacing: 40) {
      Text(player)
        .prominent()

      ZStack {
        GridShape()
          .stroke(.crewPurple, lineWidth: 5)
          .scaledToFit()

        LazyVGrid(columns: GridItem.widthThree, spacing: 5) {
          ForEach(game.board) { cell in
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .fill(.crewDarkGray)
                .shadow(color: .white, radius: 5)
                .scaledToFit()

              Text(cell.description)
                .font(.orbitron())
                .textCase(.uppercase)
                .foregroundStyle(cell == .x ? .crewBlue : .crewGreen)
            }
            .padding()
            .contentShape(Rectangle())
            .cellFeedback(cell.state)
            .onTapGesture { game.makeMove(cell) }
            .disabled(game.isComputerMove)
          }
        }
      }
      .padding(25)
      
      Spacer()
    }
    .padding()
    .background(.crewDarkGray)
    .navigationBarBackButtonHidden()
    .onAppear { game.initiate(vsComputer) }
    .task(id: game.currentPlayer) {
      game.result = GameLogic.gameOver(for: game)

      guard game.result == nil else { return }
      guard game.currentPlayer == game.computerPlayer else { return }

      try? await Task.sleep(for: .seconds(1))

      game.board[ComputerLogic.getBestMove(game: game, difficulty: difficulty)].state = game.computerPlayer

      switch game.currentPlayer {
      case .x: game.currentPlayer = .o
      case .o: game.currentPlayer = .x
      }
    }
    .navigationDestination(item: $game.result) { _ in
      Score(state: $game, vsComputer: vsComputer)
    }
  }
}
