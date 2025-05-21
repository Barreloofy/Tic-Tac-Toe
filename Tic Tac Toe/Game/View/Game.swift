//
// Game.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:37 PM
//

import SwiftUI

struct Game: View {
  @State private var state = GameState()
  @State private var finalBoard: Cells?

  let vsComputer: Bool
  private let columns = Array(repeating: GridItem(spacing: 5), count: 3)

  var player: String {
    state.isComputerMove ? "Computer's turn" : "Player \(state.currentPlayer.rawValue.uppercased())'s turn"
  }

  var body: some View {
    VStack(spacing: 50) {
      Text(player)
        .prominent(size: 35)

      ZStack {
        GridShape()
          .stroke(.crewPurple, lineWidth: 5)
          .scaledToFit()

        LazyVGrid(columns: columns, spacing: 5) {
          ForEach(state.board) { cell in
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .fill(.crewDarkGray)
                .shadow(color: .white, radius: 5)
                .scaledToFit()

              Text(cell.description)
                .font(.custom("Orbitron", size: 30))
                .textCase(.uppercase)
            }
            .padding()
            .contentShape(Rectangle())
            .cellAnimation(state: cell.state)
            .onTapGesture { state.makeMove(cell) }
            .disabled(state.isComputerMove)
          }
        }
      }
      .padding(25)
      
      Spacer()
    }
    .padding()
    .background(.crewDarkGray)
    .navigationBarBackButtonHidden()
    .onAppear { state.initiate(vsComputer) }
    .task(id: state.currentPlayer) {
      if GameLogic.gameOver(for: state) != nil { finalBoard = state.board }

      guard state.currentPlayer == state.computerPlayer else { return }

      try? await Task.sleep(for: .seconds(1))

      if state.board.filter({ $0 == nil }).count == 9 {
        state.board[.random(in: (0..<9))].state = state.computerPlayer
      } else {
        state.board[ComputerLogic.getBestMove(game: state)].state = state.computerPlayer
      }

      switch state.currentPlayer {
      case .x: state.currentPlayer = .o
      case .o: state.currentPlayer = .x
      }
    }
    .navigationDestination(item: $finalBoard) { board in
      Score(board: board, vsComputer: vsComputer)
    }
  }
}
