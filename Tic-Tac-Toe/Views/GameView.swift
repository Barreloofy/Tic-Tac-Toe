//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 8:14 PM.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    @State private var gameData = GameData()
    @State private var gameOver = false
    @State private var vsComputer: Bool
    @State private var tappedIndex: Int?
    @State private var buttonSoundEffect: AVAudioPlayer?
    private let buttonSoundEffectURL: URL?
    private var computerIsPlayerX = false
    
    init(_ vsComputer: Bool) {
        self.vsComputer = vsComputer
        (self.buttonSoundEffect, self.buttonSoundEffectURL) = try! configureSound("notification-beep", "mp3")
        self.computerIsPlayerX = assignPlayerX(vsComputer)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.crewDarkGray
                    .ignoresSafeArea()
                VStack {
                    Text(newPlayerTurn())
                        .padding(.top, 10)
                        .font(.title)
                        .rotationEffect(Angle(degrees: -2.5))
                    GeometryReader { geometry in
                        let sizeLimit = min(geometry.size.width, geometry.size.height) * 0.8
                        Grid()
                            .stroke(.crewPurple, lineWidth: 5)
                            .frame(width: sizeLimit, height: sizeLimit)
                            .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                        DrawBoard(board: gameData.board, action: { index in handleTap(index: index) }) { view, index in
                            view
                                .scaleEffect(tappedIndex == index ? 1.05 : 1.0)
                                .animation(.spring, value: tappedIndex)
                        }
                        .frame(width: sizeLimit, height: sizeLimit)
                        .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                    }
                    .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                .padding(10)
                .fontWeight(.black)
                .foregroundStyle(.crewOrange)
                .shadow(color: .gray, radius: 8, x: 5, y: -5)
                .onChange(of: gameData.turnCount, initial: true) {
                    computerMove()
                }
                .navigationDestination(isPresented: $gameOver) {
                    ResultView(gameData, vsComputer, computerIsPlayerX)
                        .navigationBarBackButtonHidden()
                }
                .onDisappear {
                    buttonSoundEffect?.stop()
                }
            }
        }
    }
}

private extension GameView {
    
    func assignPlayerX(_ vsComputer: Bool) -> Bool {
        guard vsComputer else { return false }
        return Bool.random()
    }
    
    func animateTap(_ index: Int) {
        guard gameData.board[index] == "" else { return }
        tappedIndex = index
        Task {
            try await Task.sleep(nanoseconds: 250_000_000)
            tappedIndex = nil
        }
    }
    
    func playButtonSound(_ index: Int) throws {
        guard gameData.board[index] == "" else { return }
        guard let url = buttonSoundEffectURL else { throw SoundError.nilURL() }
        buttonSoundEffect = try? AVAudioPlayer(contentsOf: url)
        buttonSoundEffect?.play()
    }
    
    func newPlayerTurn() -> String {
        if gameData.turnCount == 0 {
            return computerIsPlayerX ? "Computer begins" : "Player X begins"
        }
        if gameData.turnCount % 2 == 0 {
            return computerIsPlayerX ? "Computer's turn" : "It's Player X's turn"
        }
        return (vsComputer == true && computerIsPlayerX == false) ? "Computer's turn" : "It's Player O's turn"
    }
    
    func handleTap(index: Int) {
        Task {
            async let buttonSound: () = playButtonSound(index)
            async let buttonTap: () = animateTap(index)
            
            try? await buttonSound
            await buttonTap
            if vsComputer == true && gameData.turnCount % 2 != 0 {
                gameData.updateBoard(index: index)
                gameOver = gameData.endGame()
            } else {
                gameData.updateBoard(index: index)
                gameOver = gameData.endGame()
            }
        }
    }
    
    func computerMove() {
        guard vsComputer == true else { return }
        if (computerIsPlayerX == true && gameData.turnCount % 2 == 0) || (computerIsPlayerX == false && gameData.turnCount % 2 != 0) {
            Task {
                try await Task.sleep(nanoseconds: gameData.turnCount == 0 ? 0 : 500_000_000)
                guard let computerMove = miniMax(gameData, true, computerIsPlayerX).index else {
                    gameOver = true
                    return
                }
                async let buttonSound: () = playButtonSound(computerMove)
                async let buttonTap: () = animateTap(computerMove)
                
                try? await buttonSound
                await buttonTap
                gameData.updateBoard(index: computerMove)
                gameOver = gameData.endGame()
            }
        }
    }
}

#Preview {
    GameView(false)
}
