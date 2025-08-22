//
// Board.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/23/25 at 11:31 PM
//

import SwiftUI

struct Board<Content: View>: View {
  let board: Cells
  let cellContent: (Cell) -> Content

  init(_ board: Cells, cellContent: @escaping (Cell) -> Content) {
    self.board = board
    self.cellContent = cellContent
  }

  private let boardLayout = Array(repeating: GridItem(spacing: 0), count: 3)

  var body: some View {
    ZStack {
      BoardGrid()

      LazyVGrid(columns: boardLayout, spacing: 0) {
        ForEach(board) { cellContent($0) }
      }
    }
  }
}


extension Board where Content == CellView {
  init(_ board: Cells) {
    self.init(board) { CellView($0) }
  }
}
