//
// CellView.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/29/25 at 8:07 PM
//

import SwiftUI

struct CellView: View {
  @Environment(\.colorScheme) private var colorScheme

  let cell: Cell

  init(for cell: Cell) {
    self.cell = cell
  }

  private let shadowBlur = 4.0

  var body: some View {
    ZStack {
      RoundedRectangle()
        .fill(colorScheme.background)
        .shadow(color: .wistful, radius: shadowBlur)
        .shadow(color: .neonPurple.opacity(0.25), radius: shadowBlur * 2)
        .scaledToFill()

      Text(cell.description)
        .font(.orbitron(size: .large))
        .textCase(.uppercase)
        .foregroundStyle(colorScheme.playerColor(cell.value))
    }
    .padding(20)
  }
}
