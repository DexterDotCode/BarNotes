//
//  Customization+Extensions.swift
//  TopNotes
//
//  Created by Tanish Mittal on 28/03/25.
//

/// Enums for Font Design and Theme
import SwiftUI


enum ThemeColors: String, CaseIterable, Identifiable {
	case blue, yellow, green, purple, indigo, pink, translucent
	
	var id: Self { self }
	
	var bgColorLabel: String {
		switch self {
			case .blue: "Blue"
			case .yellow: "Yellow"
			case .green: "Green"
			case .purple: "Purple"
			case .indigo: "Indigo"
			case .pink: "Pink"
			case .translucent: "Translucent"
		}
	}
	
	var bgColor: Color {
		switch self {
			case .blue: .bgBlue
			case .yellow: .bgYellow
			case .green: .bgGreen
			case .purple: .bgPurple
			case .indigo: .bgIndigo
			case .pink: .bgPink
			case .translucent: .clear
		}
	}
	
	var fontColor: Color {
		switch self {
			case .blue: .fontBlue
			case .yellow: .fontYellow
			case .green: .fontGreen
			case .purple: .fontPurple
			case .indigo: .fontIndigo
			case .pink: .fontPink
			case .translucent: .fontDefault
		}
	}
}
