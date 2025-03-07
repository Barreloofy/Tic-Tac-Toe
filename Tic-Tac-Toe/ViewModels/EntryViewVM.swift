//
//  EntryViewVM.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 3/7/25 at 4:23 PM.
//

import Foundation
import AVFAudio
import OSLog

private let logger = Logger(subsystem: "com.Tic-Tac-Toe.EntryVM", category: "Error")

@MainActor
@Observable
final class EntryViewModel {
    var vsPlayerWasPressed = false
    var vsComputerWasPressed = false
    let buttonSoundEffect: AVAudioPlayer!
    
    init() {
        buttonSoundEffect = try! configureSound("pop-1", "mp3")
    }
}
