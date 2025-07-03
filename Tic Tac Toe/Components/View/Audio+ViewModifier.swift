//
// Audio+ViewModifier.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/26/25 at 5:10 PM
//

import SwiftUI
import AVFoundation

struct AudioOnChange<T: Equatable>: ViewModifier {
  @State private var player: AVAudioPlayer?

  let name: String
  let value: T

  func body(content: Content) -> some View {
    content
      .onChange(of: value) {
        player?.currentTime = .zero
        player?.play()
      }
      .onAppear { player = AudioManager.createPlayer(name) }
      .onDisappear { player?.stop() }
  }
}


extension View {
  /// Plays audio when trigger value changes.
  /// - Parameters:
  ///   - name: The name of an audio-file present in Bundle.main.
  ///   - trigger: A value whose type conforms to Equatable, on change plays audio.
  /// - Returns: A view that plays audio when 'trigger' changes.
  func audio<T: Equatable>(_ name: String, trigger: T) -> some View {
    modifier(AudioOnChange(name: name, value: trigger))
  }
}
