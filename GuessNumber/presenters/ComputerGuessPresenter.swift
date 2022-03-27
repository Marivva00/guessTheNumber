//
//  ComputerGuessPresenter.swift
//  GuessNumber
//
//  Created by administrator on 25.03.2022.
//

protocol ComputerGuessViewPresenter {
    init(gameModel: ComputerGuessGameModel, view: ComputerGuess)
    func lessNumber()
    func moreNumber()
    func incAttempts()
}

class ComputerGuessPresenter: ComputerGuessViewPresenter {
    
    weak var view: ComputerGuess?
    
    private var gameModel: ComputerGuessGameModel
    
    required init(gameModel: ComputerGuessGameModel, view: ComputerGuess) {
        self.gameModel = gameModel
        self.view = view
        
        firstAttempt()
        setupViewHandlers()
    }
    
    private func setupViewHandlers() {
        view?.didLoadView = { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.setRound(round: self.gameModel.attemptsToGuess)
            self.view?.setPredictNumber(number: self.gameModel.predictNumber)
        }
    }
    
    func incAttempts() {
        gameModel.attemptsToGuess += 1
    }
    
    func lessNumber() {
        incAttempts()
        gameModel.maxNumber = gameModel.predictNumber
        gameModel.predictNumber = predictNumber(min: gameModel.minNumber, max: gameModel.maxNumber)
        
        view?.setRound(round: gameModel.attemptsToGuess)
        view?.setPredictNumber(number: gameModel.predictNumber)
    }
    
    func moreNumber() {
        incAttempts()
        gameModel.minNumber = gameModel.predictNumber
        if gameModel.maxNumber == gameModel.predictNumber {
            gameModel.maxNumber = gameModel.predictNumber * 2
        }
        gameModel.predictNumber = predictNumber(min: gameModel.minNumber, max: gameModel.maxNumber)
        
        view?.setRound(round: gameModel.attemptsToGuess)
        view?.setPredictNumber(number: gameModel.predictNumber)
    }
    
    private func predictNumber(min: Int, max: Int) -> Int {
        guard min != max else {
            return min
        }
        return Int.random(in: min..<max)
    }
    
    private func firstAttempt() {
        incAttempts()
        
        gameModel.minNumber = 0
        gameModel.maxNumber = 100
        gameModel.predictNumber = predictNumber(min: gameModel.minNumber, max: gameModel.maxNumber)
    }
}

