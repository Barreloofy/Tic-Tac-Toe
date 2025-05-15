//
// Board.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/12/25 at 12:43 PM
//

import SwiftUI

struct Board: View {
  let content: [Cell]

  let columns = Array(repeating: GridItem(spacing: 5), count: 3)

  var body: some View {
    ZStack {
      GridShape()
        .stroke(.crewPurple, lineWidth: 5)
        .scaledToFit()

      LazyVGrid(columns: columns, spacing: 5) {
        ForEach(content) { cell in
          ZStack {
            RoundedRectangle(cornerRadius: 10)
              .fill(.crewDarkGray)
              .shadow(color: .white, radius: 5)
              .scaledToFit()

            Text(cell.state.rawValue)
              .textCase(.uppercase)
          }
          .padding()
        }
      }
    }
  }
}
