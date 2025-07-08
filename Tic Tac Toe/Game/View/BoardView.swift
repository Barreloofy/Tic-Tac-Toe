//
// BoardView.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/23/25 at 11:31 PM
//

import SwiftUI

struct BoardView<Content: View>: View {
  let board: Cells

  let cellContent: (Cell) -> Content

  var body: some View {
    ZStack {
      BoardGrid()

      LazyVGrid(columns: GridItem.threeColumnLayout, spacing: 5) {
        ForEach(board) { cellContent($0) }
      }
    }
  }
}


extension BoardView where Content == CellView {
  init(board: Cells) {
    self.init(board: board) { CellView(cell: $0) }
  }
}
