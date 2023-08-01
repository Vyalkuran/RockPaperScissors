//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by sebastian.popa on 8/1/23.
//

import SwiftUI

struct ContentView: View {
    
    let choices = ["🪨", "📄", "✂️"]
    let winningMap = [
        "🪨": "✂️",
        "📄": "🪨",
        "✂️": "📄"
    ]
    let maxRounds = 10
    
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var currentRound = 1
    @State private var endOfRoundMessage = ""
    @State private var didPlayerChooseCorrectly = false
    @State private var didPlayerLosePoint = false
    @State private var endedGame = false
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle)
                Spacer()
                Spacer()
                VStack {
                    Text("Round \(currentRound)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Text("The computer has rolled: ")
                        .font(.title)
                    Text(choices[computerChoice])
                        .font(.system(size: 76))
                    Spacer()
                    Spacer()
                }
                VStack{
                    Text("Your \(shouldWin ? "winning" : "losing") move is:")
                        .font(.title)
                    HStack {
                        ForEach(0..<3, id: \.self){ item in
                            Button(choices[item]){
                                results(item)
                            }
                            .font(.system(size: 76))
                        }
                    }
                    Spacer()
                    Text(endOfRoundMessage)
                        .foregroundColor(playerStatusColor())
                        .font(.title2)
                    Text("Score: \(score)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Spacer()
                }
            }
            .alert("You've reached the end! You got \(score) points out of 10 possible.", isPresented: $endedGame){
                Button("Try again!", role: .destructive) {
                    resetGame()
                }
                Button("Quit app", role: .cancel) {
                    exit(0)
                }
            }
        }
        .foregroundColor(.white)
    }
    
    func results(_ choice: Int){
        var winningMove = choices[choice]
        var losingMove = choices[computerChoice]
        
        if shouldWin == false {
            swap(&winningMove, &losingMove)
        }
        
        if winningMap[winningMove] == losingMove{
            didPlayerChooseCorrectly = true
            didPlayerLosePoint = false
            score += 1
            endOfRoundMessage = "Correct! Point +1"
        } else if(choices[choice] == choices[computerChoice]){
            endOfRoundMessage = "Draw! Point -0"
            didPlayerChooseCorrectly = false
            didPlayerLosePoint = false
        } else{
            score -= 1
            endOfRoundMessage = "Incorrect! Point -1"
            didPlayerLosePoint = true
            didPlayerChooseCorrectly = false
        }
        if currentRound == 10{
            endedGame = true
        } else {
            currentRound += 1
            shouldWin = Bool.random()
            computerChoice = Int.random(in: 0..<3)
        }
    }
    
    func playerStatusColor() -> Color{
        if didPlayerChooseCorrectly == true {
            return Color.green
        } else if didPlayerLosePoint == true {
            return Color.red
        } else if didPlayerChooseCorrectly == false && didPlayerLosePoint == false{
            return Color.yellow
        }
        return Color.black
    }
    
    func resetGame(){
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        score = 0
        currentRound = 1
        endOfRoundMessage = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
