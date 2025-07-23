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
					.font(.system(.title2, design: .rounded).bold())
					.multilineTextAlignment(.center)
				
				Text("I build this app with love. If it made you smile, you can send a sweet little thank you my way! 🍫")
					.font(.system(.body, design: .rounded))
					.multilineTextAlignment(.center)
					.padding(.bottom, 16)
				
				ForEach(store.items) { item in
					TipRow(item)
				}
			}
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
					.font(.system(.title3, design: .rounded).bold())
				Text(item.description)
					.font(.system(.callout, design: .rounded).weight(.regular))
			}
			
			Spacer()
			
			Button(item.displayPrice) {
				Task { await store.purchase(item) }
			}
			.tint(.blue)
			.buttonStyle(.bordered)
			.font(.callout.bold())
		}
	}
}
