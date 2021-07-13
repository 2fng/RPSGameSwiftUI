//
//  ContentView.swift
//  rps game
//
//  Created by Hua Son Tung on 10/15/20.
//

import SwiftUI

struct ContentView: View {
    
    let rps = ["rock","paper","scissors"]
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var computerPoints: Int = 0
    @State private var userPoints: Int = 0
    @State private var showingScore = false
    @State private var gameEnd: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("Choose your move!")
                            .font(.system(size: 30))
                            .navigationBarTitle("Rock-Paper-Scissors")
                    }
                    .padding(.top , 80)
                    .padding(.bottom , 30)
                    HStack {
                        ForEach(0..<3) { move in
                            Button(action: {
                                self.moveChosen(move)
                            }) {
                                Image(self.rps[move]).resizable()
                                    .myImageModifier()
                            }
                            
                        }
                    }
                    VStack {
                        Text("Your score: \(userPoints) ")
                            .padding()
                        Text("Computer score: \(computerPoints) ")
                            .padding()
                    }
                    .font(.system(size: 20))
                    .padding(50)
                    Spacer()
                }
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(gameEnd ? "Game over" : "Computer choose: "), message: Text(gameEnd ? "You: \(userPoints) - Computer: \(computerPoints) " : "\(rps[computerChoice])"), dismissButton: .default(gameEnd ? Text("New game") : Text("Continue")) {
                if computerPoints == 3 || userPoints == 3 {
                    if computerPoints == 3 {
                        self.resetGame()
                    }
                    else if (userPoints) == 3 {
                        self.resetGame()
                    }
                }
                else {
                    self.nextRound()
                }
            })
        })
    }
    
    func moveChosen(_ move: Int) {
        gameRule(rps[move])
        showingScore = true
        if computerPoints == 3 || userPoints == 3 {
            gameEnd = true
        }
        else {
            gameEnd = false
        }
    }

    func gameRule(_ chosenMove: String) {
        switch chosenMove {
        case "rock":
            if rps[computerChoice] == "paper" {
                computerPoints += 1
            }
            else if (rps[computerChoice] == "scissors") {
                userPoints += 1
            }
            else {
                // draw
            }
        case "paper":
            if rps[computerChoice] == "scissors" {
                computerPoints += 1
            }
            else if (rps[computerChoice] == "rock") {
                userPoints += 1
            }
            else {
                // draw
            }
        case "scissors":
            if rps[computerChoice] == "rock" {
                computerPoints += 1
            }
            else if (rps[computerChoice] == "paper") {
                userPoints += 1
            }
            else {
                // draw
            }
            
        default:
            print("Error!")
            break
        }
        
    }
    
    func nextRound() {
        computerChoice = Int.random(in: 0...2)
    }
    func resetGame() {
        computerPoints = 0
        userPoints = 0
    }
    
}



extension Image {
    func myImageModifier() -> some View {
        self
            .frame(width: 100, height: 100)
            .padding(5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
