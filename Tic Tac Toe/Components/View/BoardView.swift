//
// BoardView.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/23/25 at 11:31 PM
//

import SwiftUI

struct BoardView: View {
  let board: Cells

  var body: some View {
    ZStack {
      GridShape()
        .stroke(.neonPurple, lineWidth: 5)
        .scaledToFit()

      LazyVGrid(columns: GridItem.widthThree, spacing: 5) {
        ForEach(board) { cell in
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
        }
      }
    }
    .padding(.horizontal, 50)
  }
}
