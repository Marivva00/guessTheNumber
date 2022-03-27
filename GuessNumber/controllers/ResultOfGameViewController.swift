//
//  ResultOfGameViewController.swift
//  GuessNumber
//
//  Created by administrator on 20.03.2022.
//

import UIKit

class ResultOfGameViewController: UIViewController {
    
    var result = "You "
    
    private enum Constants {
        static let margin: CGFloat = 20
        static let bottomMargin: CGFloat = 200
        static let congratulationsLabelText: String = "Congratulations"
        static let viewBackgroundColor: UIColor = UIColor.white
        static let textColor: UIColor = UIColor.black
    }
    
    private let congratLabel = UILabel()
    private let resLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        
        configureSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is StartGameViewController){
               self.navigationController!.popToViewController(aViewController, animated: false);
            }
        }
    }
    
    private func configureSubviews() {
        configureCongratLabel()
        configureResLabel()
        
        setupConstraints()
    }
    
    private func configureCongratLabel() {
        view.addSubview(congratLabel)
        congratLabel.textAlignment = .center
        congratLabel.text = Constants.congratulationsLabelText
        congratLabel.textColor = Constants.textColor
    }
    
    private func configureResLabel() {
        view.addSubview(resLabel)
        resLabel.textAlignment = .center
        resLabel.text = result
        resLabel.textColor = Constants.textColor
    }
    
    private func setupConstraints() {
        congratLabel.translatesAutoresizingMaskIntoConstraints = false
        resLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
    
        NSLayoutConstraint.activate([
            congratLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: Constants.margin),
            congratLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            congratLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin),
     
            resLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -Constants.bottomMargin),
            resLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: Constants.margin),
            resLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -Constants.margin)
        ])
    }
}
