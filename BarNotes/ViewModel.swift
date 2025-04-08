//
//  ViewModel.swift
//  TopNotes
//
//  Created by Tanish Mittal on 03/04/25.
//

import Foundation
import KeychainAccess

extension ContentView {
	
	/// View model for ContentView.
	/// This holds all the major functionality for loading notes and saving them.
	@Observable @MainActor
	class ViewModel {
		
		/// Variable in which notes are saved temporarily.
		var notes: String = ""
		
		/// A task that saves the user's note after a short delay.
		var savingTask: Task<Void, any Error>?
		
		/// Variable that shows 'Options' popover.
		var showPopover: Bool = false
		
		/// An instance of Kishikawa Katsumi's Keychain class, to handle securely reading and writing user's notes.
		let keychain = Keychain(service: "com.dextercode.BarNotes")
		
		
		/**
		 Load notes from the user's keychain on launch.
		 */
		func loadNotes() {
			notes = keychain["notes"] ?? ""
		}
		
		/**
		 Saves the user's latest note using a sleeping task to avoid writing to keychain on every keypress.
		 * Delay saving by 1 second for efficiency.
		 * If there is currently a sleeping save task active, cancel it now to avoid multiple writes to the keychain.
		 */
		func saveNotes(newValue: String) {
			savingTask?.cancel()
			
			savingTask = Task {
				try await Task.sleep(for: .seconds(1))
				keychain["notes"] = newValue
			}
		}
	}
}
