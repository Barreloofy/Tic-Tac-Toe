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

    path.drawLine(from: CGPoint(x: rect.maxX * (factor * 1), y: rect.minY), toY: rect.maxY)
    path.drawLine(from: CGPoint(x: rect.maxX * (factor * 2), y: rect.minY), toY: rect.maxY)

    path.drawLine(from: CGPoint(x: rect.minX, y: rect.maxY * (factor * 1)), toX: rect.maxX)
    path.drawLine(from: CGPoint(x: rect.minX, y: rect.maxY * (factor * 2)), toX: rect.maxX)

    return path
  }
}


struct BoardGrid: View {
  var strokeStyle = Color.neonPurple

  var body: some View {
    GridShape()
      .stroke(strokeStyle, lineWidth: 5)
      .scaledToFit()
  }
}


extension Path {
  /// Convenience method for drawing a line, then appending it to path,
  /// combines 'move(to:)' and 'addLine(to:)' but only requires the starting point and the deviating end point to be defined.
  /// In cases where the end point varies, e.g, one axes deviated, this method provides a streamlined interface.
  mutating func drawLine(from start: CGPoint, toX x: CGFloat? = nil, toY y: CGFloat? = nil) {
    self.move(to: start)
    self.addLine(to: CGPoint(x: x ?? start.x, y: y ?? start.y))
  }
}
