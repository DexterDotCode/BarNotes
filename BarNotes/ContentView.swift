//
//  ContentView.swift
//  TopNotes
//
//  Created by Tanish Mittal on 26/03/25.
//

import SwiftUI
import ServiceManagement


/// The main view for the app, showing the user's note, copy button and options button.
struct ContentView: View {
	
	/// Class that tracks the login state.
	@Environment(AppState.self) var appState
	
	/// Environment which prefers an active appearance over an inactive appearance.
	@Environment(\.appearsActive) var appearsActive
	
	/// The font size to use, defaulting to the macOS standard size.
	@AppStorage("fontSize") var fontSize = 13.0
	
	/// The font design to use, defaulting to the system font design.
	@AppStorage("fontDesign") var fontDesign: FontDesign = .system
	
	/// The theme  to use, defaulting to the default TopNotes theme.
	@AppStorage("bgColor") var theme: ThemeColors = .topNotes
	
	/// Instance of viewModel for ContentView.
	@State private var viewModel = ViewModel()
	
	var body: some View {
		VStack {
			TextEditor(text: $viewModel.notes)
				.lineSpacing(5)
				.foregroundStyle(theme.fontColor)
				.font(.system(size: fontSize))
				.fontDesign(fontDesign.design)
			
			BottomToolbar(notes: viewModel.notes, showPopover: $viewModel.showPopover)
			
				.popover(
					isPresented: $viewModel.showPopover,
					attachmentAnchor: .point(.trailing),
					arrowEdge: .bottom
				) {
					PopoverView(fontSize: $fontSize, theme: $theme, fontDesign: $fontDesign)
				}
		}
		.padding()
		.background(theme.bgColor)
		.tint(theme.fontColor)
		
		/// saveNotes function will get called when the value of notes changes.
		.onChange(of: viewModel.notes) { _, newValue in
			viewModel.saveNotes(newValue: newValue)
		}
		
		/// appState.launchAtLogin is changed by toggle. Then the app reacts accordingly
		.onChange(of: appState.launchAtLogin) { _, newValue in
			if newValue == true {
				try? SMAppService.mainApp.register()
			} else {
				try? SMAppService.mainApp.unregister()
			}
		}
		
		/// If user remove the app from Login Items in Settings directly,
		/// and the app window is also opened,
		/// Then this onChanged method updates the UI state
		/// when the app window regains focus by using the appearsActive environment value.
		.onChange(of: appearsActive) { _, newValue in
			guard newValue else { return }
			if SMAppService.mainApp.status == .enabled {
				appState.launchAtLogin = true
			} else {
				appState.launchAtLogin = false
			}
		}
		
		/// Checking the current login status of the app to ensure the UI is up to date.
		.onAppear {
			if SMAppService.mainApp.status == .enabled {
				appState.launchAtLogin = true
			} else {
				appState.launchAtLogin = false
			}
		}
		
		/// Loading notes from keychain on appearing.
		.onAppear(perform: viewModel.loadNotes)
	}
}
