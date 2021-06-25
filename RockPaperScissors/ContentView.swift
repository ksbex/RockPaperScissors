//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kevin Becker on 6/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var computerMove = Int.random (in: 0..<3)
    @State private var playerMove = 0
    @State private var playerShouldWin = Bool.random()
    @State private var playerDidWin = false
    @State private var score = 0
    @State private var questionCount = 1
    @State private var gameOver = false
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    func moveTapped (_ number: Int) {
        switch number {
        case 0:
            //player selected Rock
            playerDidWin = (computerMove == 2)
        case 1:
            //player selected Paper
            playerDidWin = (computerMove == 0)
        case 2:
            //player selected Scissors
            playerDidWin = (computerMove == 1)
        default:
            // player lost or tied
                playerDidWin = false
        }
            if (playerDidWin == playerShouldWin) {
                score += 1
            } else {
                score -= 1
            }
            computerMove = Int.random(in: 0..<3)
            playerShouldWin = Bool.random()
            questionCount += 1
        if questionCount > 10 {
            gameOver = true
        }
        
    }
    
    func newGame (){
        computerMove = Int.random (in: 0..<3)
        playerMove = 0
        playerShouldWin = Bool.random()
        playerDidWin = false
        score = 0
        questionCount = 1
        gameOver = false
        
    }
    
    var body: some View {
        VStack {
            Text("The computer selected")
            Text(moves[computerMove])
            
            Text("This round you need to \(playerShouldWin ? "Win" : "Lose")")
           
            Text("Your choice")
         
            HStack {
                ForEach(0..<3) { number in
                    Button(action: {
                        self.moveTapped(number)
                    }) {
                        Text(self.moves[number])
                    }
                }
            }
            Text("Score: \(score)")
       
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Over"), message: Text ("Your score is \(score)"), dismissButton: .default(Text("Play Again")) {
                    self.newGame()
                })
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
