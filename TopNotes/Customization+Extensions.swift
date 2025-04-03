//
//  Customization+Extensions.swift
//  TopNotes
//
//  Created by Tanish Mittal on 28/03/25.
//

import SwiftUI

enum FontDesign: String, CaseIterable, Identifiable {
	case system, monospace, rounded, serif
	
	var id: Self { self }
	
	var design: Font.Design {
		switch self {
			case .system: .default
			case .monospace: .monospaced
			case .rounded: .rounded
			case .serif: .serif
		}
	}
	
	var description: String {
		switch self {
			case .system: "San Francisco"
			case .monospace: "SF Mono"
			case .rounded: "SF Rounded"
			case .serif: "New York"
		}
	}
}


enum ThemeColors: String, CaseIterable, Identifiable {
	case topNotes, blue, yellow, green, purple, indigo, pink, clear
	
	var id: Self { self }
	
	var description: String {
		switch self {
			case .topNotes: "Default"
			case .blue: "Blue"
			case .yellow: "Yellow"
			case .green: "Green"
			case .purple: "Purple"
			case .indigo: "Indigo"
			case .pink: "Pink"
			case .clear: "Clear"
		}
	}
	
	var bgColor: Color {
		switch self {
			case .topNotes: .bgDefault
			case .blue: .bgBlue
			case .yellow: .bgYellow
			case .green: .bgGreen
			case .purple: .bgPurple
			case .indigo: .bgIndigo
			case .pink: .bgPink
			case .clear: .clear
		}
	}
	
	var fontColor: Color {
		switch self {
			case .topNotes: .fontDefault
			case .blue: .fontBlue
			case .yellow: .fontYellow
			case .green: .fontGreen
			case .purple: .fontPurple
			case .indigo: .fontIndigo
			case .pink: .fontPink
			case .clear: .fontDefault
		}
	}
}
