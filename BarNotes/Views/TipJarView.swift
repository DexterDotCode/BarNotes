//
//  TipJar.swift
//  BarNotes
//
//  Created by Tanish Mittal on 23/07/25.
//

import StoreKit
import SwiftUI


struct TipJarView: View {
	@Environment(TipsStore.self) var store
	@State private var showTips = false
	@State private var showThanks = false
	
	var body: some View {
		List {
			VStack(spacing: 10) {
				Text("Loving the app so far?")
					.font(.title2)
					.bold()
				
				Text("I build this app with love. If it made you smile, you can send a sweet little thank you my way! 🍫")
					.font(.body)
					.padding(.bottom, 16)
				
				ForEach(store.items) { item in
					TipRow(item)
				}
			}
			.fontDesign(.rounded)
			.multilineTextAlignment(.center)
		}
		.scrollDisabled(true)
		.frame(width: 370, height: 350, alignment: .topLeading)
	}
}


#Preview {
	TipJarView()
		.environment(TipsStore())
}


private extension TipJarView {
	
	@ViewBuilder func TipRow(_ item: Product) -> some View {
		HStack {
			VStack(alignment: .leading, spacing: 5) {
				Text(item.displayName)
					.font(.headline)
				Text(item.description)
					.font(.subheadline)
			}
			.fontDesign(.rounded)
			
			Spacer()
			
			Button(item.displayPrice) {
				Task { await store.purchase(item) }
			}
			.buttonStyle(.bordered)
			.font(.callout.bold())
		}
	}
}
