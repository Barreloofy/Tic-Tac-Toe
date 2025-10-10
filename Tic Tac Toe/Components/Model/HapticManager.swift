//
// HapticManager.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/2/25 at 12:13 AM
//

import CoreHaptics
import os

/// The underlying implementation for playback of haptic patterns for this app.
final class HapticManager {
  /// The shared singleton session.
  ///
  /// > Important:
  /// This property will always be initialized even when CoreHaptics is not available.
  /// interacting with `session` in such cases is safe, but will produce no effect.
  @MainActor static let session = HapticManager()

  private let engine: CHHapticEngine?

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: "HapticManager")

  private init() {
    self.engine = try? CHHapticEngine()
    self.engine?.isAutoShutdownEnabled = true
  }

  /// Play haptics from the provided pattern.
  ///
  /// > Note:
  /// If no haptics are played, check the output of `HapticManager` logger.
  ///
  /// - Parameter pattern: The pattern to play.
  func play(pattern: CHHapticPattern?) {
    do {
      guard let engine = engine else { throw CHHapticError(.serverInitFailed) }

      guard let pattern = pattern else { throw CHHapticError(.invalidPatternData) }

      let player = try engine.makePlayer(with: pattern)

      try player.start(atTime: .zero)
    } catch {
      logger.error("\(error)")
    }
  }
}
