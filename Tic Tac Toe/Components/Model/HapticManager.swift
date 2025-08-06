//
// HapticManager.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/2/25 at 12:13 AM
//

import CoreHaptics
import os

/// The underlying implementation for advanced haptic patterns for this App.
class HapticManager {
  /// The shared session for HapticManager,
  ///
  /// > Important:
  /// This property will always be initialized even when CoreHaptics is not available.
  /// interacting with `session` in such cases is safe, but will produce no effect.
  @MainActor static let session = HapticManager()

  private let engine: CHHapticEngine?

  private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "HapticManager")

  private init() {
    self.engine = try? CHHapticEngine()
    self.engine?.isAutoShutdownEnabled = true
  }

  /// Fire-and-forget method to play a haptic pattern.
  /// - Parameters:
  ///   - pattern: The CHHapticPattern to play.
  /// - Throws: An error of `CHHapticError`.
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
