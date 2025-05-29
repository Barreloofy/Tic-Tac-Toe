//
// Sound+ViewModifier.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/26/25 at 5:10 PM
//

import SwiftUI
import AVFoundation

struct SoundOnTap: ViewModifier {
  @State private var soundEffect: AVAudioPlayer?

  let name: String

  func body(content: Content) -> some View {
    content
      .simultaneousGesture(
        TapGesture()
          .onEnded { soundEffect?.play() })
      .onAppear { soundEffect = Sound.prepare(name) }
      .onDisappear { soundEffect?.stop() }
  }
}


struct SoundConditionally<T: Hashable>: ViewModifier {
  @State private var soundEffect: AVAudioPlayer?

  let name: String
  let trigger: T

  func body(content: Content) -> some View {
    content
      .onChange(of: trigger) { soundEffect?.play() }
      .onAppear { soundEffect = Sound.prepare(name) }
      .onDisappear { soundEffect?.stop() }
  }
}


extension View {
  func sound(_ name: String) -> some View {
    modifier(SoundOnTap(name: name))
  }

  func sound<T: Hashable>(_ name: String, trigger: T) -> some View {
    modifier(SoundConditionally(name: name, trigger: trigger))
  }
}
