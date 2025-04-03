//
//  TopNotesApp.swift
//  TopNotes
//
//  Created by Tanish Mittal on 26/03/25.
//

import SwiftUI

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
