//
// Game.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/14/25 at 6:37 PM
//

import SwiftUI

struct Game: View {
  @State private var state = GameState()
  @State private var scale = 1.0

  let columns = Array(repeating: GridItem(spacing: 5), count: 3)

  var body: some View {
    VStack(spacing: 50) {
      Text("Player \(state.currentPlayer.rawValue.uppercased())'s turn")
        .prominent(size: 35)

      ZStack {
        GridShape()
          .stroke(.crewPurple, lineWidth: 5)
          .scaledToFit()

        LazyVGrid(columns: columns, spacing: 5) {
          ForEach($state.board) { $cell in
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .fill(.crewDarkGray)
                .shadow(color: .white, radius: 5)
                .scaledToFit()

              Text(cell.state.rawValue)
                .font(.custom("Orbitron", size: 30))
                .textCase(.uppercase)
            }
            .padding()
            .contentShape(Rectangle())
            .cellAnimation(state: cell.state)
            .simultaneousGesture(
              TapGesture()
                .onEnded { _ in
                  guard cell.state == .empty else { return }

                  cell.state = state.makeMove()
                }
            )
          }
        }
      }
      .padding(25)

      Spacer()
    }
    .padding()
    .background(.crewDarkGray)
    .navigationBarBackButtonHidden()
  }
}
