//
//  GameController.swift
//  GuessNumber
//
//  Created by administrator on 19.03.2022.
//

import UIKit

protocol ComputerGuess: AnyObject {
    var didLoadView: (() -> Void)? { get set }
    func setRound(round: Int)
    func setPredictNumber(number: Int)
}

final class ComputerGuessViewController: UIViewController {

    var didLoadView: (() -> Void)?
    var presenter: ComputerGuessViewPresenter?
    
    private enum Constants {
        static let margin: CGFloat = 20
        static let bottomDivConstraint: CGFloat = 8
        static let sideDivConstraint: CGFloat = 16
        static let widthDivConstraint: CGFloat = 4
        static let roundLabelText: String = "Round #*"
        static let gameModeLabelText: String = "computer guesses"
        static let predictionLabelText: String = "Your number is *"
        static let moreButtonText: String = ">"
        static let lessButtonText: String = "<"
        static let equalButtonText: String = "="
        static let viewBackgroundColor: UIColor = UIColor.white
        static let textColor: UIColor = UIColor.black
        static let buttonBackgroundColor: UIColor = UIColor.lightGray
    }
    
    private let roundLabel = UILabel()
    private let modeLabel = UILabel()
    private let predictionLabel = UILabel()
    private let moreButton = UIButton()
    private let equalButton = UIButton()
    private let lessButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        
        configureSubviews()
        didLoadView?()
    }

    private func configureSubviews() {
        configureRoundLabel()
        configureModeLabel()
        configurePredictionLabel()
    
        configureMoreButton()
        configureEqualButton()
        configureLessButton()
        
        setupConstraints()
    }
    
    private func configureRoundLabel() {
        view.addSubview(roundLabel)
        roundLabel.textAlignment = .center
        roundLabel.text = Constants.roundLabelText
        roundLabel.textColor = Constants.textColor
    }
    
    private func configureModeLabel() {
        view.addSubview(modeLabel)
        modeLabel.textAlignment = .center
        modeLabel.text = Constants.gameModeLabelText
        modeLabel.textColor = Constants.textColor
    }

    private func configurePredictionLabel() {
        view.addSubview(predictionLabel)
        predictionLabel.textAlignment = .center
        predictionLabel.text = Constants.predictionLabelText
        predictionLabel.textColor = Constants.textColor
    }
    
    private func configureMoreButton() {
        view.addSubview(moreButton)
        moreButton.setTitle(Constants.moreButtonText, for: .normal)
        moreButton.setTitleColor(Constants.textColor, for: .normal)
        moreButton.backgroundColor = Constants.buttonBackgroundColor
        moreButton.addTarget(self, action: #selector(moreButtonAction), for: .touchUpInside)
    }
    
    private func configureEqualButton() {
        view.addSubview(equalButton)
        equalButton.setTitle(Constants.equalButtonText, for: .normal)
        equalButton.setTitleColor(Constants.textColor, for: .normal)
        equalButton.backgroundColor = Constants.buttonBackgroundColor
        equalButton.addTarget(self, action: #selector(equalButtonAction), for: .touchUpInside)
    }
    
    private func configureLessButton() {
        view.addSubview(lessButton)
        lessButton.setTitle(Constants.lessButtonText, for: .normal)
        lessButton.setTitleColor(Constants.textColor, for: .normal)
        lessButton.backgroundColor = Constants.buttonBackgroundColor
        lessButton.addTarget(self, action: #selector(lessButtonAction), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        modeLabel.translatesAutoresizingMaskIntoConstraints = false
        predictionLabel.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        equalButton.translatesAutoresizingMaskIntoConstraints = false
        lessButton.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
        let constButtomConstraint = view.frame.height / Constants.bottomDivConstraint
        let constSideButtonConstraint = view.bounds.width / Constants.sideDivConstraint
        let widthConstraint = view.bounds.width / Constants.widthDivConstraint
    
        NSLayoutConstraint.activate([
            roundLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: Constants.margin),
            roundLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            roundLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
        
            modeLabel.topAnchor.constraint(equalTo: roundLabel.bottomAnchor, constant: Constants.margin),
            modeLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            modeLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
     
            predictionLabel.topAnchor.constraint(equalTo: modeLabel.bottomAnchor,
                                                 constant: Constants.margin),
            predictionLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            predictionLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
        
            moreButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor,
                                               constant: -constButtomConstraint),
            moreButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: constSideButtonConstraint),
            moreButton.widthAnchor.constraint(equalToConstant: widthConstraint),
       
            equalButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor,
                                                constant: -constButtomConstraint),
            equalButton.leftAnchor.constraint(equalTo: moreButton.rightAnchor,
                                              constant: constSideButtonConstraint),
            equalButton.widthAnchor.constraint(equalToConstant: widthConstraint),
        
            lessButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor,
                                               constant: -constButtomConstraint),
            lessButton.leftAnchor.constraint(equalTo: equalButton.rightAnchor,
                                             constant: constSideButtonConstraint),
            lessButton.rightAnchor.constraint(equalTo: guide.rightAnchor,
                                              constant: -constSideButtonConstraint),
            lessButton.widthAnchor.constraint(equalToConstant: widthConstraint)
        ])
    }
    
    @objc private func moreButtonAction(sender: UIButton!) {
        presenter?.moreNumber()
    }
    
    @objc private func equalButtonAction(sender: UIButton!) {
        let resultViewController = ResultOfGameViewController()
        resultViewController.result = "You lose"
        navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    @objc private func lessButtonAction(sender: UIButton!) {
        presenter?.lessNumber()
    }
}

extension ComputerGuessViewController: ComputerGuess {
    
    func setRound(round: Int) {
        self.roundLabel.text = "Round #\(round)"
    }
    
    func setPredictNumber(number: Int) {
        self.predictionLabel.text = "Your number is \(number)"
    }
}
