//
// HapticFeedback.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/2/25 at 12:47 AM
//

import SwiftUI
import CoreHaptics

struct HapticFeedback: ViewModifier {
  let pattern: CHHapticPattern?
  let condition: () -> Bool

  func body(content: Content) -> some View {
    content
      .onAppear {
        guard condition() else { return }

        HapticManager.session.play(pattern: pattern)
      }
  }
}


extension View {
  /// Plays a haptic pattern on-appear if the provided condition evaluates true.
  /// - Parameters:
  ///   - pattern: The `CHHapticPattern` to play, if the value is nil, returns and no haptics are played.
  ///   - condition: The closure to evaluate.
  func hapticFeedback(_ pattern: CHHapticPattern?, condition: @escaping () -> Bool) -> some View {
    modifier(HapticFeedback(pattern: pattern, condition: condition))
  }
}
