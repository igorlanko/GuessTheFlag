//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by stranger on 2023-09-26.
//

import SwiftUI

struct FlagsView: View {
	var countryNumber: String
	
	var body: some View {
		Image(countryNumber)
			.renderingMode(.original)
			.clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
	}
}

struct ScreenTitle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle.weight(.semibold))
			.foregroundColor(.white)
	}
}

struct ContentView: View {
	struct Game {
		var showingScore = false
		var gameEnded = false
		var scoreTitle = ""
		var score: Int = 0
		
		var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
		var correctAnswer = Int.random(in: 0...2)
		
		var round: Int = 0 {
			didSet {
				if round >= 8 {
					gameEnded = true
				}
 			}
		}
	}
	
	@State private var game = Game()
	
    var body: some View {
		ZStack {
			LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			
			VStack(spacing: 32) {
				Spacer()
				
				VStack {
					Text("Tap the flag of")
						.foregroundColor(.white)
					Text(game.countries[game.correctAnswer])
						.modifier(ScreenTitle())
				}
				
				ForEach(0..<3) { number in
					Button {
						flagTapped(number)
					} label: {
						FlagsView(countryNumber: game.countries[number])
					}
				}
				
				Spacer()
				Spacer()
				
				Text("Score: \(game.score) • Round \(game.round)/8")
					.foregroundStyle(Color.white)
				
				Spacer()
			}
		}
		.alert(game.scoreTitle, isPresented: $game.showingScore) {
			Button("Continue", action: askQuestion)
		}  message: {
			Text("Your score \(game.score)")
		}
		.alert("Congrats! Game complete", isPresented: $game.gameEnded) {
			Button("New game", action: reset)
		} message: {
			Text("Your score is \(game.score).")
		}
	}
	
	func flagTapped(_ number: Int) {
		if number == game.correctAnswer {
			game.scoreTitle = "Correct!"
			game.score += 1
			game.round += 1
		} else {
			game.scoreTitle = "Wrong! That's the flag of \(game.countries[game.correctAnswer])."
			game.score -= 1
			game.round += 1
		}
		
		game.showingScore = true
	}
	
	func askQuestion() {
		game.countries.shuffle()
		game.correctAnswer = Int.random(in: 0...2)
	}
	
	func reset() {
		game.gameEnded = false
		game.round = 0
	}
}

#Preview {
    ContentView()
}
