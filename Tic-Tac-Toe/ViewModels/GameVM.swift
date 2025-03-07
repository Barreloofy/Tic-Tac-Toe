//
//  GameVM.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 3/7/25 at 5:29 PM.
//

import Foundation
import AVFoundation
import OSLog

private let logger = Logger(subsystem: "com.Tic-Tac-Toe-GameVM", category: "Error")

@MainActor
@Observable
final class GameViewModel {
    var gameData = GameData()
    var computerIsPlayerX = false
    var gameOver = false
    var vsComputer: Bool
    var tappedIndex: Int?
    private let buttonSoundEffect: AVAudioPlayer!
    
    init(_ vsComputer: Bool) {
        self.vsComputer = vsComputer
        
        do {
            #if os(iOS)
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            #endif
            self.buttonSoundEffect = try configureSound("notification-beep", "mp3")
        } catch {
            logger.error("\(error.localizedDescription)")
            fatalError()
        }
        buttonSoundEffect.prepareToPlay()
        
        assignPlayerX()
    }
    
    func assignPlayerX() {
        guard vsComputer else { return }
        
        computerIsPlayerX = Bool.random()
    }
    
    func animateTap(_ index: Int) async throws {
        guard gameData.board[index] == "" else { return }
        
        tappedIndex = index
        try await Task.sleep(nanoseconds: 250_000_000)
        tappedIndex = nil
    }
    
    func playButtonSound(_ index: Int) {
        guard gameData.board[index] == "" else { return }
        
        buttonSoundEffect.currentTime = 0
        buttonSoundEffect.play()
    }
    
    func newPlayerTurn() -> String {
        if gameData.turnCount == 0 {
            return computerIsPlayerX ? "Computer begins" : "Player X begins"
        } else if gameData.turnCount % 2 == 0 {
            return computerIsPlayerX ? "Computer's turn" : "It's Player X's turn"
        } else {
            return (vsComputer == true && computerIsPlayerX == false) ? "Computer's turn" : "It's Player O's turn"
        }
    }
    
    func playerMove(index: Int) {
        Task(priority: .high) {
            do {
                playButtonSound(index)
                try await animateTap(index)
                
                if vsComputer == true && gameData.turnCount % 2 != 0 {
                    gameData.updateBoard(index: index)
                    gameOver = gameData.endGame()
                } else {
                    gameData.updateBoard(index: index)
                    gameOver = gameData.endGame()
                }
            } catch {
                logger.error("\(error.localizedDescription)")
            }
        }
    }
    
    func computerMove() {
        guard vsComputer == true else { return }
        guard computerIsPlayerX == true && gameData.turnCount % 2 == 0 || computerIsPlayerX == false && gameData.turnCount % 2 != 0 else { return }
        
        Task(priority: .high) {
            do {
                try await Task.sleep(nanoseconds: gameData.turnCount == 0 ? 0 : 500_000_000)
                
                guard let computerMove = miniMax(gameData, true, computerIsPlayerX).index else {
                    gameOver = true
                    return
                }
                
                playButtonSound(computerMove)
                try await animateTap(computerMove)
                gameData.updateBoard(index: computerMove)
                gameOver = gameData.endGame()
            } catch {
                logger.error("\(error.localizedDescription)")
            }
        }
    }
}
