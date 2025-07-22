//
//  AnimatableFontModifier.swift
//  BarNotes
//
//  Created by Tanish Mittal on 22/07/25.
//

import SwiftUI


struct AnimatableFontModifier: ViewModifier, @preconcurrency Animatable {
	var size: Double
	
	var animatableData: Double {
		get { size }
		set { size = newValue }
	}
	
	func body(content: Content) -> some View {
		content
			.font(.system(size: size))
	}
}

extension View {
	func animatableFontSize(size: Double) -> some View {
		self
			.modifier(AnimatableFontModifier(size: size))
	}
}
