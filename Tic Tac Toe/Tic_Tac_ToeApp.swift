//
// Tic_Tac_ToeApp.swift
// Tic Tac Toe
//
// Created by Barreloofy on 5/12/25 at 12:43 PM
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
            .foregroundStyle(.crewOrange)
            .fontWeight(.bold)
            .statusBarHidden()
        }
    }
}
