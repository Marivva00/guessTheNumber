//
//  VariantsOfGuess.swift
//  GuessNumber
//
//  Created by administrator on 24.03.2022.
//

enum VariantsOfGuess {
    case equal
    case less
    case more
    
    func getString() -> String {
        switch self {
        case .equal:
            return "="
        case .less:
            return "<"
        case .more:
            return ">"
        }
    }
}
