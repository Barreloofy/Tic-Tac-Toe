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

func generateBoardContent() -> [String] {
    var freeBoardPosition = (0...8).map { $0 }
    freeBoardPosition.shuffle()
    return freeBoardPosition.map { $0 % 2 == 0 ? "X" : "O"}
}

func DrawBoard
(
    board: [String] = generateBoardContent(),
    action: @escaping (Int) -> Void = { _ in },
    modifier: @escaping (AnyView, Int) -> some View = { content, index in content}
) -> some View {
    return LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
        ForEach(board.indices, id: \.self) { index in
            let content = RoundedRectangle(cornerRadius: 10)
                .fill(.crewDarkGray)
                .aspectRatio(contentMode: .fit)
                .padding(10)
                .overlay {
                    Text(board[index])
                        .font(.largeTitle)
                        .foregroundStyle(PlayerColor(board[index]))
                }
                .onTapGesture {
                    action(index)
                }
            modifier(AnyView(content), index)
        }
    }
}

func PlayerColor(_ content: String) -> Color {
    return content == "X" ? .crewBlue : .crewGreen
}

func configureSound(_ fileName: String, _ ofType: String) throws -> AVAudioPlayer {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: ofType) else { throw SoundError.nilResource() }
    return try AVAudioPlayer(contentsOf: url)
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
