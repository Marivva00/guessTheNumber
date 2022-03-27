//
//  GameModel.swift
//  GuessNumber
//
//  Created by administrator on 20.03.2022.
//

struct UserGuessGameModel {
    var attemptsToGuess = 0
    let number: Int
    
    init() {
        number = Int.random(in: 1..<100)
    }
}
