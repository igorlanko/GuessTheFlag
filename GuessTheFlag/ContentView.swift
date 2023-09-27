//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by stranger on 2023-09-26.
//

import SwiftUI

struct ContentView: View {
	@State private var showingScore = false
	@State private var scoreTitle = ""
	
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	
    var body: some View {
		ZStack {
			LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			
			VStack(spacing: 32) {
				VStack {
					Text("Tap the flag of")
						.foregroundColor(.white)
					Text(countries[correctAnswer])
						.font(.largeTitle.weight(.semibold))
						.foregroundColor(.white)
				}
				
				ForEach(0..<3) { number in
					Button {
						flagTapped(number)
					} label: {
						Image(countries[number])
							.renderingMode(.original)
							.clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
					}
				}
			}
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		}  message: {
			Text("Your score ???")
		}
	}
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "Correct"
		} else {
			scoreTitle = "Wrong"
		}
		
		showingScore = true
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

#Preview {
    ContentView()
}
