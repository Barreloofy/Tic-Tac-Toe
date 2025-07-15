//
// VictoryFeedback.swift
// Tic Tac Toe
//
// Created by Barreloofy on 7/1/25 at 2:10 PM
//

import CoreHaptics

extension CHHapticPattern {
  static var victoryFeedback: CHHapticPattern? {
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    let event = CHHapticEvent(
      eventType: .hapticContinuous,
      parameters: [intensity, sharpness],
      relativeTime: 0,
      duration: 2)

    let initialIntensity = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 0)
    let peakIntensity = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 1)
    let dipIntensity = CHHapticParameterCurve.ControlPoint(relativeTime: 1.25, value: 0.25)
    let finalIntensity = CHHapticParameterCurve.ControlPoint(relativeTime: 1.75, value: 0.75)
    let intensityCurve = CHHapticParameterCurve(
      parameterID: .hapticIntensityControl,
      controlPoints: [initialIntensity, peakIntensity, dipIntensity, finalIntensity],
      relativeTime: 0)

    let sharpnessStart = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 0)
    let sharpnessEnd = CHHapticParameterCurve.ControlPoint(relativeTime: 1.75, value: 1)
    let sharpnessCurve = CHHapticParameterCurve(
      parameterID: .hapticSharpnessControl,
      controlPoints: [sharpnessStart, sharpnessEnd],
      relativeTime: 0)

    return try? CHHapticPattern(events: [event], parameterCurves: [intensityCurve, sharpnessCurve])
  }
}
