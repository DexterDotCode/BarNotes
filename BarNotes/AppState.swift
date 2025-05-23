//
//  AppState.swift
//  TopNotes
//
//  Created by Tanish Mittal on 03/04/25.
//

import Foundation

/// Class that tracks the app state for launch at login feature.
@Observable
class AppState {
	
	/// By default the app shouldn't be allowed to launch at login, without user's permission ~ Apple.
	var launchAtLogin = false
}
