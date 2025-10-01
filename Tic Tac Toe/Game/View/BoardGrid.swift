//
// BoardGrid.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/13/25 at 2:34 PM
//

import SwiftUI

struct GridShape: Shape {
  nonisolated func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
    let knownSize = proposal.replacingUnspecifiedDimensions()

    let size = min(knownSize.width, knownSize.height)

    return .init(width: size, height: size)
  }

  func path(in rect: CGRect) -> Path {
    Path { path in
      let xFraction = rect.maxX / 3
      let yFraction = rect.maxY / 3
      let fractionalPositions = [1.0, 2.0]

      fractionalPositions.forEach { position in
        path.drawLine(from: .init(x: xFraction * position, y: rect.minY), toY: rect.maxY)
        path.drawLine(from: .init(x: rect.minX, y: yFraction * position), toX: rect.maxX)
      }
    }
  }
}


struct BoardGrid: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    GridShape()
      .stroke(colorScheme.grid, lineWidth: 8)
  }
}


extension Path {
  mutating func drawLine(from start: CGPoint, toX x: CGFloat? = nil, toY y: CGFloat? = nil) {
    self.move(to: start)
    self.addLine(to: CGPoint(x: x ?? start.x, y: y ?? start.y))
  }
}
