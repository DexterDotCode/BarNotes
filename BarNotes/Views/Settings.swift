//
//  PopoverView.swift
//  TopNotes
//
//  Created by Tanish Mittal on 03/04/25.
//

import SwiftUI
import StoreKit

struct Settings: View {
	@Environment(AppState.self) var appState
	@Environment(\.openURL) private var openURL
	
	@Binding var fontSize: Double
	@Binding var theme: ThemeColors
	@Binding var fontDesign: FontDesign
	@AppStorage("menubarIcon") private var menubarIcon: MenuBarIcon = .pencil
	
	var body: some View {
		@Bindable var appState = appState
		
		List {
			VStack(alignment: .leading, spacing: 25) {
				HStack {
					Text("Font Size")

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
				
				Picker("Background Color", selection: $theme) {
					ForEach(ThemeColors.allCases) { bgColor in
						Text(bgColor.bgColorLabel)
					}
					
				}
				
				Picker("Menu Bar Icon", selection: $menubarIcon) {
					ForEach(MenuBarIcon.allCases) { menubarIcon in
						Image(systemName: menubarIcon.icon)
							.tint(.primary)
					}
 				}
				
				Toggle("Launch at login", isOn: $appState.launchAtLogin)
					.toggleStyle(.switch)
				
				Spacer()
				
				HStack {
					Link(destination: URL(string: "https://github.com/dexterdotcode/barnotes")!) {
						Text("Github")
					}
					.tint(.blue)
					.buttonStyle(.accessoryBar)
					
					Spacer()
					
					Button("Leave a Review") {
						let url = URL(string: "https://apps.apple.com/app/id6744329261?action=write-review")!
						openURL(url)
					}
					.buttonStyle(.bordered)
					
					Spacer()
					
					Button("Quit") {
						NSApp.terminate(nil)
					}
					.tint(.red)
					.buttonStyle(.accessoryBar)
				}
			}
			.fontWeight(.medium)
		}
		.scrollDisabled(true)
		.frame(width: 370, height: 330, alignment: .topLeading)
	}
}
