//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by stranger on 2023-09-26.
//

import SwiftUI

struct ContentView: View {
	var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"]
	var correctAnswer = Int.random(in: 0...2)
	
    var body: some View {
		ZStack {
			Color.blue.ignoresSafeArea()
			
			VStack(spacing: 32) {
				VStack {
					Text("Tap the flag of")
						.foregroundColor(.white)
					Text(countries[correctAnswer])
						.foregroundColor(.white)
				}
				
				ForEach(0..<3) { number in
					Button {
						// flag was tapped
					} label: {
						Image(countries[number])
							.renderingMode(.original)
					}
				}
			}
		}
	}
}

#Preview {
    ContentView()
}
