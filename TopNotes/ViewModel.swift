//
//  ViewModel.swift
//  TopNotes
//
//  Created by Tanish Mittal on 03/04/25.
//

import Foundation
import KeychainAccess

extension ContentView {
	
	@Observable @MainActor
	class ViewModel {
		var notes: String = ""
		var savingTask: Task<Void, any Error>?
		var showPopover: Bool = false
		
		let keychain = Keychain(accessGroup: "com.dextercode.TopNotes")
		
		// Load notes from the keychain
		func loadNotes() {
			notes = keychain["notes"] ?? ""
		}
		
		// Delay saves by sleeping for 2 seconds for efficiency.
		func saveNotes(newValue: String) {
			savingTask?.cancel()
			
			savingTask = Task {
				try await Task.sleep(for: .seconds(2))
				keychain["notes"] = newValue
			}
		}
	}
}
