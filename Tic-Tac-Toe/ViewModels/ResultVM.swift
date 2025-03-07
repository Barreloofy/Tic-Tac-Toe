//
//  ResultVM.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 3/7/25 at 9:48 PM.
//

import Foundation
import AVFoundation
import OSLog

private let logger = Logger(subsystem: "com.Tic-Tac-Toe.ResultVM", category: "Error")

@MainActor
@Observable

final class ResultViewModel {
    let gameData: GameData
    let vsComputer: Bool
    let computerIsPlayerX: Bool
    let resultSoundEffect: AVAudioPlayer!
    let buttonSoundEffect: AVAudioPlayer!
    var playAgain = false
    var wasPressedPlayAgain = false
    var wasPressedHome = false
    
    init(_ gameData: GameData, _ vsComputer: Bool, _ computerIsPlayerX: Bool) {
        self.gameData = gameData
        self.vsComputer = vsComputer
        self.computerIsPlayerX = computerIsPlayerX
        
        do {
            self.buttonSoundEffect = try configureSound("pop-1", "mp3")
            self.resultSoundEffect = try configureSound("level-up-3", "mp3")
        } catch {
            logger.error("\(error.localizedDescription)")
            fatalError()
        }
    }
    
    func presentResult() -> String {
        guard let result = gameData.result else { return "It's a Draw!" }
        switch result {
            case "Player X":
                if vsComputer == true && computerIsPlayerX == true {
                    return "Computer won"
                } else {
                    return "Player X won"
                }
            default:
                if vsComputer == true && computerIsPlayerX == false {
                    return "Computer won"
                } else {
                    return "Player O won"
                }
        }
    }
}
