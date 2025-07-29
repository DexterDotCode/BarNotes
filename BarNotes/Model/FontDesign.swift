//
//  FontDesign.swift
//  BarNotes
//
//  Created by Tanish Mittal on 29/07/25.
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
