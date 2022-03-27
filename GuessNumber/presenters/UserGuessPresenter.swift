//
//  GamePresenter.swift
//  GuessNumber
//
//  Created by administrator on 20.03.2022.
//

protocol UserGuessViewPresenter {
    init(gameModel: UserGuessGameModel, view: UserGuess)
    func newAttemptToGuess(with userNumber: Int)
    func incAttempts()
}

class UserGuessPresenter: UserGuessViewPresenter {
    
    weak var view: UserGuess?
    
    private var gameModel: UserGuessGameModel
    
    required init(gameModel: UserGuessGameModel, view: UserGuess) {
        self.gameModel = gameModel
        self.view = view
    }
    
    func newAttemptToGuess(with userNumber: Int) {
        incAttempts()
     
        view?.setRound(round: gameModel.attemptsToGuess)
        view?.setResult(result: checkNumber(number: userNumber))
    }
    
    func incAttempts() {
        gameModel.attemptsToGuess += 1
    }
    
    private func checkNumber(number: Int) -> VariantsOfGuess {
        if gameModel.number == number {
            return .equal
        } else if gameModel.number > number {
            return .more
        } else {
            return .less
        }
    }
}
