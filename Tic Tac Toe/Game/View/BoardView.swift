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
      GridTicTacToe()

      LazyVGrid(columns: GridItem.threeColumnLayout, spacing: 5) {
        ForEach(board) { cell in
          CellView(cell: cell)
        }
      }
    }
    .padding(.horizontal, 50)
  }
}
