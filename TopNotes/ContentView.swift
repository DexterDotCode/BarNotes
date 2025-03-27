//
//  ContentView.swift
//  TopNotes
//
//  Created by Tanish Mittal on 26/03/25.
//

import SwiftUI
import KeychainAccess

struct ContentView: View {
	@AppStorage("fontSize") var fontSize = 14.0
	@State private var notes: String = ""
	@State private var savingTask: Task<Void, Error>?
	let keychain = Keychain(accessGroup: "com.dextercode.TopNotes")
	
	
	var body: some View {
		VStack {
			TextEditor(text: $notes)
				.font(.system(size: fontSize))
				.frame(width: 400, height: 400)
			
			HStack {
				ControlGroup {
					Button("Decrease font size", systemImage: "textformat.size.smaller") {
						fontSize -= 1
					}
					Button("Decrease font size", systemImage: "textformat.size.larger") {
						fontSize += 1
					}
				}
				
				ControlGroup {
					Button("Copy note", systemImage: "doc.on.doc") {
						NSPasteboard.general.clearContents()
						NSPasteboard.general.setString(notes, forType: .string)
					}
					Button("Quit", systemImage: "power") {
						NSApp.terminate(nil)
					}
				}
			}
		}
		.padding()
		.onAppear(perform: loadNotes)
		.onChange(of: notes, perform: saveNotes)
	}
	
	func loadNotes() {
		notes = keychain["notes"] ?? ""
	}
	
	func saveNotes(newValue: String) {
		savingTask?.cancel()
		
		savingTask = Task {
			try await Task.sleep(for: .seconds(2))
			keychain["notes"] = newValue
		}
	}
}

#Preview {
	ContentView()
}
