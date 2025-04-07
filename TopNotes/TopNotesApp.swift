//
//  TopNotesApp.swift
//  TopNotes
//
//  Created by Tanish Mittal on 26/03/25.
//

import SwiftUI

/// The main struct of our app, responsible for setting up our user interface as a macOS menu bar app showing as a window.
@main
struct TopNotesApp: App {
    var body: some Scene {
		MenuBarExtra("TopNotes", systemImage: "inset.filled.circle") {
            ContentView()
				.environment(AppState())
				.frame(width: 400, height: 350)
        }
		.menuBarExtraStyle(.window)
    }
}
