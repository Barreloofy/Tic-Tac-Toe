//
//  GridShape.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/28/24 at 3:47 PM.
//

import SwiftUI

struct Grid<S>: View where S: ShapeStyle {
    let style: S
    let lineWidth: CGFloat
    
    init(_ style: S = .black, _ lineWidth: CGFloat = 1) {
        self.style = style
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        return GridShape().stroke(style, lineWidth: lineWidth)
    }
    
    private struct GridShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPointZero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            var yFactor: CGFloat = 0.333
            for _ in 0..<2 {
                path.move(to: CGPoint(x: rect.minX, y: rect.maxY * yFactor))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * yFactor))
                yFactor += 0.333
            }
            
            var xFactor: CGFloat = 0.333
            for _ in 0..<2 {
                path.move(to: CGPoint(x: rect.maxX * xFactor, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX * xFactor, y: rect.maxY))
                xFactor += 0.333
            }
            
            return path
        }
    }
}
