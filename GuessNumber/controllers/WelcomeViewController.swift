//
//  ViewController.swift
//  GuessNumber
//
//  Created by administrator on 19.03.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private enum Constants {
        static let margin: CGFloat = 20
        static let marginDiv: CGFloat = 12
        static let gameName: String = "Guess the Number"
        static let buttonLabel: String = "Start New Game"
        static let viewBackgroundColor: UIColor = UIColor.white
        static let buttonBackgroundColor: UIColor = UIColor.lightGray
        static let textColor: UIColor = UIColor.black
    }
    
    private let gameNameLabel = UILabel()
    private let startGameButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        
        configureSubviews()
    }

    private func configureSubviews() {
        configureGameNameLabel()
        configureStartGameButton()
        setupConstraints()
    }
    
    private func configureGameNameLabel() {
        view.addSubview(gameNameLabel)
        gameNameLabel.textAlignment = .center
        gameNameLabel.text = Constants.gameName
        gameNameLabel.textColor = Constants.textColor
    }
    
    private func configureStartGameButton() {
        view.addSubview(startGameButton)
        startGameButton.setTitle(Constants.buttonLabel, for: .normal)
        startGameButton.setTitleColor(Constants.textColor, for: .normal)
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        startGameButton.backgroundColor = Constants.buttonBackgroundColor
    }
    
    private func setupConstraints() {
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
    
        NSLayoutConstraint.activate([
            gameNameLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: Constants.margin),
            gameNameLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            gameNameLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
        
            startGameButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            startGameButton.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
            startGameButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor,
                                                    constant: -view.frame.height / Constants.marginDiv)
        ])
    }
    
    @objc private func startGame(sender: UIButton!) {
        navigationController?.pushViewController(StartGameViewController(), animated: true)
    }
}

