//
// CellView.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/29/25 at 8:07 PM
//

import SwiftUI

struct CellView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  let cell: Cell

  init(for cell: Cell) {
    self.cell = cell
  }

  private let shadowBlur = 4.0

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(colorScheme.background)
        .shadow(color: .wistful, radius: shadowBlur)
        .shadow(color: .neonPurple.opacity(0.25), radius: shadowBlur)
        .scaledToFit()

      Text(cell.description)
        .font(.orbitron(size: .large))
        .textCase(.uppercase)
        .foregroundStyle(cell == .x ? colorScheme.playerX : colorScheme.playerO)
    }
    .padding(horizontalSizeClass == .regular ? 24 : 16)
  }
}
