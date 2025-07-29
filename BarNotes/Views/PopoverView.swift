//
//  PopoverView.swift
//  TopNotes
//
//  Created by Tanish Mittal on 03/04/25.
//

import SwiftUI
import StoreKit

struct PopoverView: View {
	@Environment(AppState.self) var appState
	@Environment(\.openURL) private var openURL
	
	@Binding var fontSize: Double
	@Binding var theme: ThemeColors
	@Binding var fontDesign: FontDesign
	
	var body: some View {
		@Bindable var appState = appState
		
		List {
			VStack(alignment: .leading, spacing: 25) {
				HStack {
					Text("Font Size")
						.fontWeight(.medium)
					Spacer()
					ControlGroup {
						Button("Decrease font size", systemImage: "minus") {
							withAnimation(.spring) { fontSize -= 1 }
						}
						
						Button("Increase font size", systemImage: "plus") {
							withAnimation(.spring) { fontSize += 1 }
						}
					}
				}
				
				Picker("Note Font", selection: $fontDesign) {
					ForEach(FontDesign.allCases) { font in
						Text(font.description)
					}
				}
				.fontWeight(.medium)
				
				Picker("Background Color", selection: $theme) {
					ForEach(ThemeColors.allCases) { bgColor in
						Text(bgColor.bgColorLabel)
					}
				}
				.fontWeight(.medium)
				
				Toggle("Launch at login", isOn: $appState.launchAtLogin)
					.fontWeight(.medium)
					.toggleStyle(.switch)
				
				Spacer()
				
				HStack {
					Link(destination: URL(string: "https://github.com/dexterdotcode/barnotes")!) {
						Text("Github")
							.fontWeight(.medium)
					}
					
					Spacer()
					
					Button("Leave a Review") {
						let url = URL(string: "https://apps.apple.com/app/id6744329261?action=write-review")!
						openURL(url)
					}
					.fontWeight(.medium)
					.buttonStyle(.bordered)
					
					Spacer()
					
					Button("Quit") {
						NSApp.terminate(nil)
					}
					.fontWeight(.medium)
					.tint(.red)
					.buttonStyle(.accessoryBar)
				}
			}
		}
		.scrollDisabled(true)
		.frame(width: 370, height: 285, alignment: .topLeading)
	}
}
