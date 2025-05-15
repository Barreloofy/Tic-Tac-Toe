//
// GridShape.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/13/25 at 2:34 PM
//

import SwiftUI

struct GridShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let factor: CGFloat = 1 / 3

    path.move(to: CGPointZero)
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPointZero)
    path.closeSubpath()

    path.move(to: CGPoint(x: rect.maxX * (factor * 1), y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX * (factor * 1), y: rect.maxY))

    path.move(to: CGPoint(x: rect.maxX * (factor * 2), y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX * (factor * 2), y: rect.maxY))

    path.move(to: CGPoint(x: rect.minX, y: rect.maxY * (factor * 1)))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * (factor * 1)))

    path.move(to: CGPoint(x: rect.minX, y: rect.maxY * (factor * 2)))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * (factor * 2)))

    return path
  }
}
