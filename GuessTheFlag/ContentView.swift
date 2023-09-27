//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by stranger on 2023-09-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		ZStack {
			VStack(spacing: 0) {
				Color.red
				Color.blue
			}
			
			Text("Content")
				.foregroundStyle(.secondary)
				.padding(50)
				.background(.ultraThinMaterial)
		}
		.ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
