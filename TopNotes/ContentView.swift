//
//  ContentView.swift
//  TopNotes
//
//  Created by Tanish Mittal on 26/03/25.
//

import SwiftUI
import KeychainAccess
import ServiceManagement

@Observable
class AppState {
	var launchAtLogin = false
}

struct ContentView: View {
	@Environment(AppState.self) var appState
	@Environment(\.appearsActive) var appearsActive
	@AppStorage("fontSize") var fontSize = 13.0
	@AppStorage("fontDesign") var fontDesign: FontDesign = .system
	@AppStorage("bgColor") var theme: ThemeColors = .topNotes
	@State private var notes: String = ""
	@State private var savingTask: Task<Void, Error>?
	@State private var showPopover: Bool = false
	let keychain = Keychain(accessGroup: "com.dextercode.TopNotes")
	
	var body: some View {
		@Bindable var appState = appState

		VStack {
			TextEditor(text: $notes)
				.lineSpacing(5)
				.foregroundStyle(theme.fontColor)
				.font(.system(size: fontSize))
				.fontDesign(fontDesign.design)
			
			BottomToolbar
			
				.popover(
					isPresented: $showPopover,
					attachmentAnchor: .point(.trailing),
					arrowEdge: .bottom
				) {
					VStack(alignment: .leading, spacing: 20) {
						FontControlGroup
						
						Picker("Note Font              ", selection: $fontDesign) {
							ForEach(FontDesign.allCases) { font in
								Text(font.description)
							}
						}
						Picker("Background Color", selection: $theme) {
							ForEach(ThemeColors.allCases) { bgColor in
								Text(bgColor.description)
							}
						}
						
						Toggle("Launch at login", isOn: $appState.launchAtLogin)
						
						Spacer()
						HStack {
							Spacer()
							QuitButton
						}
					}
					.frame(width: 300, height: 230, alignment: .topLeading)
					.padding()
				}
		}
		.padding()
		.background(theme.bgColor)
		.tint(theme.fontColor)
		.onAppear {
			if SMAppService.mainApp.status == .enabled {
				appState.launchAtLogin = true
			} else {
				appState.launchAtLogin = false
			}
			
			loadNotes()
		}
		.onChange(of: notes) {
			saveNotes(newValue: notes)
		}
		.onChange(of: appState.launchAtLogin) { _, newValue in
			if newValue == true {
				try? SMAppService.mainApp.register()
			} else {
				try? SMAppService.mainApp.unregister()
			}
		}
		.onChange(of: appearsActive) { _, newValue in
			guard newValue else { return }
			if SMAppService.mainApp.status == .enabled {
				appState.launchAtLogin = true
			} else {
				appState.launchAtLogin = false
			}
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
		.environment(AppState())
}


private extension ContentView {
	var BottomToolbar: some View {
		VStack {
			HStack {
				Button {
					NSPasteboard.general.clearContents()
					NSPasteboard.general.setString(notes, forType: .string)
				} label: {
					Image(systemName: "doc.on.doc")
				}
				.buttonStyle(.accessoryBar)
				
				Spacer()
				
				Button {
					showPopover.toggle()
				} label: {
					Image(systemName: "ellipsis")
				}
				.buttonStyle(.accessoryBar)
			}
		}
	}
	
	var FontControlGroup: some View {
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
	}
	
	var QuitButton: some View {
		Button {
			NSApp.terminate(nil)
		} label: {
			Image(systemName: "power")
		}
		.buttonStyle(.accessoryBar)
	}
}
