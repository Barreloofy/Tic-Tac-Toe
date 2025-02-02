//
//  Tic_Tac_ToeApp.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 7:32 PM.
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .containerBackground(.ultraThinMaterial, for: .window)
            #endif
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowBackgroundDragBehavior(.enabled)
        #endif
    }
}
