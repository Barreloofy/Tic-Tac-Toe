//
// CellView.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/29/25 at 8:07 PM
//

import SwiftUI

struct CellView: View {
  let cell: Cell

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .fill(.smokyBlack)
        .shadow(color: .white.opacity(0.4), radius: 5)
        .shadow(color: .wistful.opacity(0.4), radius: 5)
        .scaledToFit()

      Text(cell.description)
        .textCase(.uppercase)
        .foregroundStyle(cell == .x ? .crewBlue : .crewGreen)
    }
  }
}
