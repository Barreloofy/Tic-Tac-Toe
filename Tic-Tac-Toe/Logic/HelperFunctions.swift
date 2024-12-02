//
//  HelperFunctions.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/23/24 at 5:12 PM.
//

import SwiftUI
import AVFoundation

enum SoundError: Error, LocalizedError {
    case nilResource(String = "Sound file not found")
    case nilURL(String = "Sound URL is nil")
    
    var errorDescription: String? {
        switch self {
            case .nilResource(let message):
            return message
            case .nilURL(let message):
            return message
        }
    }
}

struct Helper {
    static func generateBoardContent() -> [String] {
        var freeBoardPosition = (0...8).map { $0 }
        freeBoardPosition.shuffle()
        return freeBoardPosition.map { $0 % 2 == 0 ? "X" : "O"}
    }
    
    static func DrawBoard(_ board: [String] = generateBoardContent()) -> some View {
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(board.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.crewDarkGray)
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .overlay {
                        Text(board[index])
                            .fontWeight(.black)
                            .foregroundStyle(PlayerColor(board, index))
                    }
            }
        }
    }
    
    static func PlayerColor(_ board: [String], _ index: Int) -> Color {
        if board[index] == "X" {
            return .crewBlue
        } else {
            return .crewGreen
        }
    }
    
    static func configureSound(_ soundEffect: inout AVAudioPlayer?, _ fileName: String, _ ofType: String) throws -> URL {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: ofType) else { throw SoundError.nilResource() }
        soundEffect = try AVAudioPlayer(contentsOf: url)
        return url
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

struct ButtonReturnAnimationModifier: ViewModifier {
    let wasPressed: Bool
    
    func body(content: Content) -> some View {
        content
            .phaseAnimator([false, true], trigger: wasPressed) { content, phase in
                content.scaleEffect(phase ? 1.10 : 1.0)
            } animation: { phase in
                phase ? .spring.speed(2.0) : .easeIn.speed(2.0)
            }
    }
}

extension View {
    func buttonReturnAnimation(_ wasPressed: Bool) -> some View {
        return self.modifier(ButtonReturnAnimationModifier(wasPressed: wasPressed))
    }
}
