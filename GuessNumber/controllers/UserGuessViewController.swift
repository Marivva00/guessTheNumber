//
//  YouGuessViewController.swift
//  GuessNumber
//
//  Created by administrator on 20.03.2022.
//

import UIKit

protocol UserGuess: AnyObject{
    func setRound(round: Int)
    func setResult(result: VariantsOfGuess)
}

class UserGuessViewController: UIViewController {
    
    var presenter: UserGuessViewPresenter?
    
    private enum Constants {
        static let textFieldFont = UIFont.systemFont(ofSize: 15)
        static let margin: CGFloat = 20
        static let bottomDivConstraint: CGFloat = 8
        static let roundLabelText: String = "Round #1"
        static let gameModeLabelText: String = "computer guesses"
        static let textFieldText: String = "Enter number here"
        static let buttonText: String = "Enter the number"
        static let resultLabelText: String = "number is *"
        static let textColor: UIColor = UIColor.black
        static let buttonBackgroundColor: UIColor = UIColor.lightGray
        static let viewBackgroundColor: UIColor = UIColor.white
    }
    
    private let roundLabel = UILabel()
    private let modeLabel = UILabel()
    private let textField = UITextField()
    private let resultLabel = UILabel()
    private let enterNumberButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        
        configureSubviews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func configureSubviews() {
        configureRoundLabel()
        configureModeLabel()
        configureTextField()
        configureEnterNumberButton()
        configureResultLabel()

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

    private func configureTextField() {
        view.addSubview(textField)
        textField.placeholder = Constants.textFieldText
        textField.font = Constants.textFieldFont
        textField.backgroundColor = Constants.buttonBackgroundColor
        textField.textColor = Constants.textColor
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    }
    
    private func configureEnterNumberButton() {
        view.addSubview(enterNumberButton)
        enterNumberButton.setTitle(Constants.buttonText, for: .normal)
        enterNumberButton.setTitleColor(Constants.textColor, for: .normal)
        enterNumberButton.backgroundColor = Constants.buttonBackgroundColor
        enterNumberButton.addTarget(self, action: #selector(enterNumber), for: .touchUpInside)
    }
    
    private func configureResultLabel() {
        view.addSubview(resultLabel)
        resultLabel.textAlignment = .center
        resultLabel.text = Constants.resultLabelText
        resultLabel.textColor = Constants.textColor
    }
    
    private func setupConstraints(){
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        modeLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        enterNumberButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
    
        NSLayoutConstraint.activate([
            roundLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: Constants.margin),
            roundLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            roundLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
       
            modeLabel.topAnchor.constraint(equalTo: roundLabel.bottomAnchor, constant: Constants.margin),
            modeLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            modeLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
       
            textField.topAnchor.constraint(equalTo: modeLabel.bottomAnchor, constant: Constants.margin),
            textField.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            textField.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
        
            enterNumberButton.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                                   constant: Constants.margin),
            enterNumberButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            enterNumberButton.rightAnchor.constraint(equalTo: guide.rightAnchor,
                                                     constant: -Constants.margin),

            resultLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            resultLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
            resultLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor,
                                                constant: -view.frame.height / Constants.bottomDivConstraint)
        ])
    }
    
    private func showWinWindow() {
        let resultViewController = ResultOfGameViewController()
        resultViewController.result = "You win"
        navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func enterNumber(sender: UIButton!) {
        guard let numberString = textField.text,
              let number = Int(numberString) else {
            return
        }
        presenter?.newAttemptToGuess(with: number)
    }
}

extension UserGuessViewController: UserGuess {
    func setRound(round: Int){
        self.roundLabel.text = "Round #\(round)"
    }
    
    func setResult(result: VariantsOfGuess){
        self.resultLabel.text = "number is " + result.getString()
        if result == .equal {
            showWinWindow()
        }
    }
}
