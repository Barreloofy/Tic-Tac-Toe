//
// BoardGrid.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/13/25 at 2:34 PM
//

import SwiftUI

struct GridShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let factor: CGFloat = 1 / 3
    let fractionalPositions = [1.0, 2.0]

    fractionalPositions.forEach { position in
      path.drawLine(from: .init(x: rect.maxX * (factor * position), y: rect.minY), toY: rect.maxY)
      path.drawLine(from: .init(x: rect.minX, y: rect.maxY * (factor * position)), toX: rect.maxX)
    }

    return path
  }
}


struct BoardGrid: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    GridShape()
      .stroke(colorScheme.grid, lineWidth: 5)
      .scaledToFit()
  }
}


extension Path {
  mutating func drawLine(from start: CGPoint, toX x: CGFloat? = nil, toY y: CGFloat? = nil) {
    self.move(to: start)
    self.addLine(to: CGPoint(x: x ?? start.x, y: y ?? start.y))
  }
}
