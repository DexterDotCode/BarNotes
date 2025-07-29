//
//  MenuBarIcon.swift
//  BarNotes
//
//  Created by Tanish Mittal on 29/07/25.
//

import Foundation


enum MenuBarIcon: String, CaseIterable, Identifiable {
	case circle, pencil, pencilTip, pencilOutline, page, paperClip, pencilAndScribble, scribble, cursor
	
	var id: Self { self }
	
	var icon: String {
		switch self {
			case .circle: "inset.filled.circle"
			case .pencil: "pencil"
			case .pencilTip: "pencil.tip"
			case .pencilOutline: "pencil.and.outline"
			case .page: "text.page"
			case .pencilAndScribble: "scribble.variable"
			case .paperClip: "paperclip"
			case .scribble: "pencil.and.scribble"
			case .cursor: "character.cursor.ibeam"
		}
	}
}
