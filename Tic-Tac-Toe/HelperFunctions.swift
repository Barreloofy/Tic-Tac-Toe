//
//  HelperFunctions.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/23/24 at 5:12 PM.
//

import SwiftUI

struct Helper {
    static func PlayerColor(_ board: [String], _ index: Int) -> Color {
        if board[index] == "X" {
            return .crewBlue
        } else {
            return .crewGreen
        }
    }
    
    static func generateBoardContent() -> [String] {
        var freeBoardPosition = (0...8).map { $0 }
        freeBoardPosition.shuffle()
        return freeBoardPosition.map { $0 % 2 == 0 ? "X" : "O"}
    }
    
    static func DrawBoard(_ board: [String] = generateBoardContent()) -> some View {
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(board.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .overlay {
                        Text(board[index])
                            .fontWeight(.black)
                            .foregroundStyle(PlayerColor(board, index))
                    }
            }
        }
    }
}

struct ButtonAnimationModifier: ViewModifier {
    @Binding var wasPressed: Bool
    let completion: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onLongPressGesture(minimumDuration: 0) {} onPressingChanged: { isPressing in
                if isPressing {
                    wasPressed = true
                } else {
                    withAnimation(.default) {
                        wasPressed = false
                    }
                    completion()
                }
            }
    }
}

extension View {
    func buttonAnimation(wasPressed: Binding<Bool>, completion: @escaping () -> Void) -> some View {
        return self.modifier(ButtonAnimationModifier(wasPressed: wasPressed, completion: completion))
    }
}
