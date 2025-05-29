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
          CellView(cell: cell)
            .padding()
        }
      }
    }
    .padding(.horizontal, 50)
  }
}
