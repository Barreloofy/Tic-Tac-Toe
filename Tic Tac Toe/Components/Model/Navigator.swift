//
// Navigator.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/22/25 at 9:22 PM
//

import SwiftUI

@Observable
class Navigator {
  var path = NavigationPath()

  func push(_ value: some Hashable) {
    path.append(value)
  }

  func popLast() {
    path.removeLast()
  }

  func popToRoot() {
    path.removeLast(path.count)
  }
}
