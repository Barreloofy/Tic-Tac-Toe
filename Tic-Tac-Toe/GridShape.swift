//
//  GridShape.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/28/24 at 3:47 PM.
//

import SwiftUI

struct Grid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let rows = 3
        let columns = 3
        
        for num in 0..<columns {
            let xPosition = rect.minX + CGFloat(num) * (width / CGFloat(columns))
            path.move(to: CGPoint(x: xPosition, y: rect.minY))
            path.addLine(to: CGPoint(x: xPosition, y: rect.maxY))
        }
        
        for num in 0..<rows {
            let yPosition = rect.minY + CGFloat(num) * (height / CGFloat(rows))
            path.move(to: CGPoint(x: rect.minX, y: yPosition))
            path.addLine(to: CGPoint(x: rect.maxX, y: yPosition))
        }
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}
