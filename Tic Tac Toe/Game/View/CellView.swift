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

  private let partialOpacity = 0.5
  private let shadowBlur: CGFloat = 4

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(colorScheme.background)
        .shadow(color: .wistful.opacity(partialOpacity), radius: shadowBlur)
        .shadow(color: .white.opacity(partialOpacity), radius: shadowBlur)
        .scaledToFit()

      Text(cell.description)
        .textCase(.uppercase)
        .foregroundStyle(cell == .x ? colorScheme.playerX : colorScheme.playerO)
    }
    .padding()
  }
}
