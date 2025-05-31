//
// AudioManager.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/26/25 at 12:17 PM
//

import AVFoundation

/// The underlying implementation of the audio interface for this App.
/// - Remark:
/// Use the static method 'createPlayer(String)' to create an instance of AVAudioPlayer with the content of an audio-file.
/// Use 'shared' with the method 'play(_ :String, with: TimeInterval)' to play an audio-file now.
class AudioManager: NSObject, AVAudioPlayerDelegate {
  @MainActor static let session = AudioManager()
  private override init() {}

  /// Returns an instance of AVAudioPlayer initialized with the content of the audio-file, identified by the 'name' parameter.
  /// - Parameters:
  ///   - name: The name of the audio-file present in 'Bundle.main'.
  /// - Returns: The initialized instance of AVAudioPlayer with the content of the audio-file.
  static func createPlayer(_ name: String) -> AVAudioPlayer? {
    guard let url = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }

    guard let player = try? AVAudioPlayer(contentsOf: url) else { return nil }

    player.prepareToPlay()
    return player
  }

  /// Set of current AVAudioPlayer instances.
  var players = Set<AVAudioPlayer>()

  /// Fire-and-forget method to play an audio-file now.
  /// - Parameters:
  ///   - name: The name of the audio-file present in 'Bundle.main'.
  ///   - delay: The amount of time before the audio is played.
  func play(_ name: String, with delay: TimeInterval = 0.5) {
    guard let player = AudioManager.createPlayer(name) else { return }
    player.delegate = self

    players.insert(player)

    player.play(atTime: player.deviceCurrentTime + delay)
  }

  // AVAudioPlayerDelegate method implementation.
  func audioPlayerDidFinishPlaying(
    _ player: AVAudioPlayer,
    successfully flag: Bool) {
    players.remove(player)
  }
}
