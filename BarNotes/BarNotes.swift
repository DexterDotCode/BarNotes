//
//  TopNotesApp.swift
//  TopNotes
//
//  Created by Tanish Mittal on 26/03/25.
//

import SwiftUI


@main
struct BarNotes: App {
	
	@AppStorage("menubarIcon") private var menubarIcon: MenuBarIcon = .pencil
	
    var body: some Scene {
		MenuBarExtra("BarNotes", systemImage: menubarIcon.icon) {
            ContentView()
				.environment(AppState())
				.environment(TipsStore())
				.frame(width: 400, height: 350)
        }
		.menuBarExtraStyle(.window)
    }
}



