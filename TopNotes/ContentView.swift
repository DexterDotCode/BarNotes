//
//  ContentView.swift
//  TopNotes
//
//  Created by Tanish Mittal on 26/03/25.
//

import SwiftUI

struct ContentView: View {
	@AppStorage("notes") var notes: String = ""
	@AppStorage("fontSize") var fontSize = 14.0
	
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
					Button("Reset font size", systemImage: "arrow.counterclockwise") {
						fontSize = 14
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
	}
}

#Preview {
	ContentView()
}
