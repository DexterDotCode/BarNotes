//
//  BottomToolbar.swift
//  TopNotes
//
//  Created by Tanish Mittal on 03/04/25.
//

import SwiftUI

struct BottomToolbar: View {
	var notes: String
	@Binding var showPopover: Bool
	
    var body: some View {
		VStack {
			HStack {
				Button {
					NSPasteboard.general.clearContents()
					NSPasteboard.general.setString(notes, forType: .string)
				} label: {
					Image(systemName: "doc.on.doc")
				}
				.accessibilityLabel("Copy note")
				.buttonStyle(.accessoryBar)
				
				Spacer()
				
				Button {
					showPopover.toggle()
				} label: {
					Image(systemName: "ellipsis")
				}
				.accessibilityLabel("Show options")
				.buttonStyle(.accessoryBar)
			}
		}
    }
}
