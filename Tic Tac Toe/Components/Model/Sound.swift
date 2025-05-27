//
// Sound.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/26/25 at 12:17 PM
//

import AVFoundation

enum Sound {
  actor Retainer {
    static let shared = Retainer()

    private init() {}

    var players: Set<AVAudioPlayer?> = []

    func play(_ name: String) {
      guard let player = prepare(name) else { return }
      players.insert(player)

      player.play(atTime: player.deviceCurrentTime + 0.25)
      while player.isPlaying {}

      players.remove(player)
    }
  }

  static func prepare(_ name: String) -> AVAudioPlayer? {
    guard let url = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }

    let player = try? AVAudioPlayer(contentsOf: url)
    player?.prepareToPlay()

    return player
  }

  static func play(_ name: String) {
    Task {
      await Retainer.shared.play(name)
    }
  }
}
