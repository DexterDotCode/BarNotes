//
//  PopoverView.swift
//  TopNotes
//
//  Created by Tanish Mittal on 03/04/25.
//

import SwiftUI

/// The popover view which holds the customization features of TopNotes.
struct PopoverView: View {
	
	/// Class that tracks the login state.
	@Environment(AppState.self) var appState
	
	/// Binding for changing font size.
	@Binding var fontSize: Double
	
	/// Binding for changing app theme.
	@Binding var theme: ThemeColors
	
	/// Binding for changing font design.
	@Binding var fontDesign: FontDesign
	
    var body: some View {
		@Bindable var appState = appState
		
		VStack(alignment: .leading, spacing: 20) {
			VStack(alignment: .leading, spacing: 7) {
				Text("Font Size")
					.font(.subheadline)
					.foregroundStyle(.secondary)
				
				ControlGroup {
					Button("Decrease font size", systemImage: "minus") {
						fontSize -= 1
					}
					Button("Increase font size", systemImage: "plus") {
						fontSize += 1
					}
				}
			}
			
			Picker("Note Font", selection: $fontDesign) {
				ForEach(FontDesign.allCases) { font in
					Text(font.description)
				}
			}
			
			Picker("Background Color", selection: $theme) {
				ForEach(ThemeColors.allCases) { bgColor in
					Text(bgColor.bgColorLabel)
				}
			}
			
			Toggle("Launch at login", isOn: $appState.launchAtLogin)
			
			Spacer()
			HStack {
				Spacer()
				Button {
					NSApp.terminate(nil)
				} label: {
					Image(systemName: "power")
				}
				.buttonStyle(.accessoryBar)
			}
		}
		.frame(width: 300, height: 230, alignment: .topLeading)
		.padding()
    }
}
