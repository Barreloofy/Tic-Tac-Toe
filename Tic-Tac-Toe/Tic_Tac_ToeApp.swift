//
//  Tic_Tac_ToeApp.swift
//  Tic-Tac-Toe
//
//  Created by Barreloofy on 11/19/24 at 7:32 PM.
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
    #if os(macOS)
    @StateObject private var windowController = WindowController()
    #endif
    
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            ContentView()
                .containerBackground(.ultraThinMaterial, for: .window)
                .onAppear {
                    windowController.setupWindow()
                }
            #else
            ContentView()
            #endif
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowBackgroundDragBehavior(.enabled)
        #endif
    }
}

#if os(macOS)
@MainActor
class WindowController: ObservableObject {
    func setupWindow() {
        guard let window = NSApp.windows.first else { return }
        guard let screen = NSScreen.main else { return }
        let screenSize = screen.frame.size
        let windowSize = window.frame.size
        let originX = (screenSize.width - windowSize.width) / 2
        let originY = (screenSize.height - windowSize.height) / 2
        window.setFrame(NSRect(x: originX, y: originY, width: windowSize.width, height: windowSize.height), display: false)
    }
}
#endif
