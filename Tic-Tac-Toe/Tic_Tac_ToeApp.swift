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
            #if os(macOS)
            EntryView()
                .containerBackground(.thinMaterial, for: .window)
            #else
            EntryView()
            #endif
        }
        #if os(macOS)
        .restorationBehavior(.disabled)
        .windowStyle(.hiddenTitleBar)
        .windowBackgroundDragBehavior(.enabled)
        .defaultSize(setSize())
        .defaultPosition(setPosition())
        #endif
    }
}

#if os(macOS)

@MainActor
func setSize() -> CGSize {
    guard let frame = NSScreen.main?.frame else { return CGSize.init(width: 1000, height: 1000) }
    let x = min(frame.maxX, frame.maxY) * 0.666
    let y = min(frame.maxX, frame.maxY) * 0.750
    return CGSize(width: x, height: y)
}

@MainActor
func setPosition() -> UnitPoint {
    guard let frame = NSScreen.main?.frame else { return .center }
    let x = frame.midX / frame.width
    let y = (frame.maxY * 0.10) / frame.height
    return UnitPoint(x: x, y: y)
    
}

#endif
