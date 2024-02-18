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
	@State private var tappedFlag = -1
	
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
//					.rotation3DEffect(.degrees(tappedFlag == number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0)) // for the task
					.scaleEffect(tappedFlag == number ? 1.25 : 1)
					.opacity(tappedFlag == -1 || tappedFlag == number ? 1 : 0.25)
					.scaleEffect(tappedFlag == -1 || tappedFlag == number ? 1 : 0.8)
					.animation(.default, value: tappedFlag)
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
			game.scoreTitle = "Wrong! That's not the flag of \(game.countries[game.correctAnswer])."
			game.score -= 1
			game.round += 1
		}
		
		game.showingScore = true
		tappedFlag = number
	}
	
	func askQuestion() {
		game.countries.shuffle()
		game.correctAnswer = Int.random(in: 0...2)
		tappedFlag = -1
	}
	
	func reset() {
		game.gameEnded = false
		game.round = 0
	}
}

#Preview {
    ContentView()
}
