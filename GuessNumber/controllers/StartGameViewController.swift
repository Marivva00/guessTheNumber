//
//  StartGameViewController.swift
//  GuessNumber
//
//  Created by administrator on 19.03.2022.
//

import UIKit

final class StartGameViewController: UIViewController {
    
    private enum Constants {
        static let margin: CGFloat = 20
        static let marginDiv: CGFloat = 12
        static let guessNumberButtonText: String = "Guess the number"
        static let enterNumberButtonText: String = "Enter the number"
        static let textFieldText: String = "Enter number here"
        static let viewBackgroundColor: UIColor = UIColor.white
        static let buttonBackgroundColor: UIColor = UIColor.lightGray
        static let textColor: UIColor = UIColor.black
    }
    
    private let guessNumberButton = UIButton()
    private let enterNumberTextField = UITextField()
    private let enterNumberButton = UIButton()
    
    private var startButtonBottomConstraint: NSLayoutConstraint?
    private var initialStartButtonBottom = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        configureSubviews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func configureSubviews() {
        configureGuessNumberButton()
        configureEnterNumberTextField()
        configureEnterNumberButton()
        setupConstraints()
    }
    
    private func configureGuessNumberButton() {
        view.addSubview(guessNumberButton)
        guessNumberButton.setTitle(Constants.guessNumberButtonText, for: .normal)
        guessNumberButton.setTitleColor(Constants.textColor, for: .normal)
        guessNumberButton.backgroundColor = Constants.buttonBackgroundColor
        guessNumberButton.addTarget(self, action: #selector(startGuessing), for: .touchUpInside)
    }
    
    private func configureEnterNumberTextField() {
        view.addSubview(enterNumberTextField)
        enterNumberTextField.placeholder = Constants.textFieldText
        enterNumberTextField.font = UIFont.systemFont(ofSize: 15)
        enterNumberTextField.backgroundColor = Constants.buttonBackgroundColor
        enterNumberTextField.textColor = Constants.textColor
        enterNumberTextField.borderStyle = UITextField.BorderStyle.roundedRect
        enterNumberTextField.autocorrectionType = UITextAutocorrectionType.no
        enterNumberTextField.keyboardType = UIKeyboardType.decimalPad
        enterNumberTextField.returnKeyType = UIReturnKeyType.done
        enterNumberTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        enterNumberTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    }
    
    private func configureEnterNumberButton() {
        view.addSubview(enterNumberButton)
        enterNumberButton.setTitle(Constants.enterNumberButtonText, for: .normal)
        enterNumberButton.setTitleColor(Constants.textColor, for: .normal)
        enterNumberButton.backgroundColor = Constants.buttonBackgroundColor
        enterNumberButton.addTarget(self, action: #selector(enterNumber), for: .touchUpInside)
    }
    
    @objc private func enterNumber(sender: UIButton!) {
        dismissKeyboard()
        guard let numberString = enterNumberTextField.text else {
            return
        }
        guard Int(numberString) != nil else {
            return
        }
        let model = ComputerGuessGameModel()
        let view = ComputerGuessViewController()
        let presenter = ComputerGuessPresenter(gameModel: model, view: view)
        view.presenter = presenter
        navigationController?.pushViewController(view, animated: true)
    }
    
    private func setupConstraints() {
        guessNumberButton.translatesAutoresizingMaskIntoConstraints = false
        enterNumberButton.translatesAutoresizingMaskIntoConstraints = false
        enterNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        initialStartButtonBottom = -view.frame.height / Constants.marginDiv
        
        let guide = view.safeAreaLayoutGuide
        
        let startButtonBottomConstraint = enterNumberButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: initialStartButtonBottom)
        self.startButtonBottomConstraint = startButtonBottomConstraint
    
        NSLayoutConstraint.activate([
            guessNumberButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: Constants.margin),
            guessNumberButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            guessNumberButton.rightAnchor.constraint(equalTo: guide.rightAnchor,
                                                     constant: -Constants.margin),
            
            enterNumberButton.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            enterNumberButton.rightAnchor.constraint(equalTo: guide.rightAnchor,
                                                     constant: -Constants.margin),
            startButtonBottomConstraint,
            
            enterNumberTextField.bottomAnchor.constraint(equalTo: enterNumberButton.topAnchor,
                                                         constant: -Constants.margin),
            enterNumberTextField.leftAnchor.constraint(equalTo: guide.leftAnchor,
                                                       constant: Constants.margin),
            enterNumberTextField.rightAnchor.constraint(equalTo: guide.rightAnchor,
                                                        constant: -Constants.margin)
        ])
    }
    
    @objc private func startGuessing(sender: UIButton!) {
        dismissKeyboard()
        let model = UserGuessGameModel()
        let view = UserGuessViewController()
        let presenter = UserGuessPresenter(gameModel: model, view: view)
        view.presenter = presenter
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {

            if let startButtonBottomConstraint = startButtonBottomConstraint,
                startButtonBottomConstraint.constant == initialStartButtonBottom {
                if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false {
                    startButtonBottomConstraint.constant -= keyboardFrame.size.height / 2
                } else {
                    startButtonBottomConstraint.constant -= keyboardFrame.size.height
                }
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if let startButtonBottomConstraint = startButtonBottomConstraint,
           startButtonBottomConstraint.constant != initialStartButtonBottom {
            startButtonBottomConstraint.constant = initialStartButtonBottom
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
