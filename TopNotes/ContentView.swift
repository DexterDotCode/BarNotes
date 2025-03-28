//
//  ContentView.swift
//  TopNotes
//
//  Created by Tanish Mittal on 26/03/25.
//

import SwiftUI
import KeychainAccess

struct ContentView: View {
	@AppStorage("fontSize") var fontSize = 13.0
	@AppStorage("fontDesign") var fontDesign: FontDesign = .system
	@AppStorage("customAccent") var fontColor: fontColor = .Blue
	@State private var notes: String = ""
	@State private var savingTask: Task<Void, Error>?
	@State private var showPopover: Bool = false
	let keychain = Keychain(accessGroup: "com.dextercode.TopNotes")
	
	var body: some View {
		VStack {
			TextEditor(text: $notes)
				.foregroundStyle(fontColor.color)
				.font(.system(size: fontSize))
				.fontDesign(fontDesign.design)
			
			VStack {
				HStack {
					Spacer()
					
					Button {
						showPopover.toggle()
					} label: {
						Image(systemName: "ellipsis")
					}
					.buttonStyle(.accessoryBar)
				}
			}
			.popover(isPresented: $showPopover, attachmentAnchor: .point(.trailing), arrowEdge: .bottom) {
				VStack(alignment: .leading, spacing: 20) {
					VStack(alignment: .leading, spacing: 7) {
						Text("Font Size")
							.font(.subheadline)
							.foregroundStyle(.secondary)
						
						ControlGroup {
							Button("Decrease font size", systemImage: "textformat.size.smaller") {
								fontSize -= 1
							}
							Button("Increase font size", systemImage: "textformat.size.larger") {
								fontSize += 1
							}
						}
					}
					
					Picker("Note Font", selection: $fontDesign) {
						ForEach(FontDesign.allCases) { font in
							Text(font.description)
								.fontDesign(font.design)
						}
					}
					
					Spacer()
					
					HStack {
						Button {
							NSPasteboard.general.clearContents()
							NSPasteboard.general.setString(notes, forType: .string)
						} label: {
							Image(systemName: "doc.on.doc")
						}
						
						Spacer()
						
						Button {
							NSApp.terminate(nil)
						} label: {
							Image(systemName: "power")
						}
					}
				}
				.frame(width: 300, height: 250, alignment: .topLeading)
				.padding()
			}
		}
		.padding()
		.background(Color.topNotesBlue)
		.onAppear(perform: loadNotes)
		.onChange(of: notes) {
			saveNotes(newValue: notes)
		}
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
