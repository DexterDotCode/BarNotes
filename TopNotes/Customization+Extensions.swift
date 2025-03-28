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
	
	var icon: String {
		switch self {
			case .system: "Aa"
			case .monospace: "00"
			case .rounded: "Rr"
			case .serif: "Ny"
		}
	}
	
	var description: String {
		switch self {
			case .system:
				"San Francisco"
			case .monospace:
				"SF Mono"
			case .rounded:
				"SF Rounded"
			case .serif:
				"New York"
		}
	}
}


enum fontColor: String, CaseIterable, Identifiable {
	case Blue, Red, Yellow, Green, Purple, Indigo, Pink
	
	var id: Self { self }
	
	var description: String {
		switch self {
			case .Blue: "Blue"
			case .Red: "Red"
			case .Yellow: "Yellow"
			case .Green: "Green"
			case .Purple: "Purple"
			case .Indigo: "Indigo"
			case .Pink: "Pink"
		}
	}
	
	var color: Color {
		switch self {
			case .Blue: .blue
			case .Red: .red
			case .Yellow: .yellow
			case .Green: .green
			case .Purple: .purple
			case .Indigo: .indigo
			case .Pink: .pink
		}
	}
}


enum CustomBGColor: String, CaseIterable, Identifiable {
	case Blue, Red, Yellow, Green, Purple, Indigo, Pink
	
	var id: Self { self }
	
	var description: String {
		switch self {
			case .Blue: "TopNotes Blue"
			case .Red: "Sunset Red"
			case .Yellow: "Sunrise Yellow"
			case .Green: "Grass Green"
			case .Purple: "Plumshade"
			case .Indigo: "Indigo"
			case .Pink: "Pink"
		}
	}
	
	var color: Color {
		switch self {
			case .Blue: .blue
			case .Red: .red
			case .Yellow: .yellow
			case .Green: .green
			case .Purple: .purple
			case .Indigo: .indigo
			case .Pink: .pink
		}
	}
}


extension Color {
	public static let topNotesBlue = Color(hex: "111F34")
}


extension Color {
	init(hex: String) {
		let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&int)
		let a, r, g, b: UInt64
		switch hex.count {
			case 3: // RGB (12-bit)
				(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
			case 6: // RGB (24-bit)
				(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
			case 8: // ARGB (32-bit)
				(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
			default:
				(a, r, g, b) = (1, 1, 1, 0)
		}
		
		self.init(
			.sRGB,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue:  Double(b) / 255,
			opacity: Double(a) / 255
		)
	}
}
