//
// Sound+ViewModifier.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/26/25 at 5:10 PM
//

import SwiftUI
import AVFoundation

struct SoundOnChange<T: Hashable>: ViewModifier {
  @State private var soundEffect: AVAudioPlayer?

  let name: String
  let value: T

  func body(content: Content) -> some View {
    content
      .onChange(of: value) {
        soundEffect?.currentTime = .zero
        soundEffect?.play()
      }
      .onAppear { soundEffect = AudioManager.createPlayer(name) }
      .onDisappear { soundEffect?.stop() }
  }
}


extension View {
  func sound<T: Hashable>(_ name: String, trigger: T) -> some View {
    modifier(SoundOnChange(name: name, value: trigger))
  }
}
