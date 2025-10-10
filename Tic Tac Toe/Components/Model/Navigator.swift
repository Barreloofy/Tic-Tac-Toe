//
// Navigator.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/22/25 at 9:22 PM
//

import SwiftUI

/// A observable `NavigationPath` providing convenient navigation methods.
@Observable
final class Navigator {
  /// The underlying `NavigationPath`.
  var path = NavigationPath()
  
  /// Adds a new value to `path`.
  ///
  /// - Parameter value: The value to add.
  func push(_ value: some Hashable) {
    path.append(value)
  }
  
  /// Removes the current value from `path`.
  func popLast() {
    path.removeLast()
  }
  
  /// Removes all values from `path`, except the root value.
  func popToRoot() {
    path.removeLast(path.count)
  }
}
