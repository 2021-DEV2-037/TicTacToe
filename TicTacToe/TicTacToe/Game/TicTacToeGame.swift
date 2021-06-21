//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by admin on 21/06/2021.
//

import Foundation
class TicTacToeGame{
    var positions: [String] = []
    var isFirstPlayer: Bool = true
    var gameStatus: GameStatus = .playing
    
    func playTurn(position: Int) throws -> GameStatus{
        guard positions[position].isEmpty else {
            throw TicTacToePlayError.notValidSelection(message: "This option is not valid.")
        }
        positions[position] = isFirstPlayer ? "X" : "O"
        return .playing
    }
    
    func resetValues() {
        positions = [String](repeating: "", count: 9)
        isFirstPlayer = true
        gameStatus = .playing
    }
}

enum GameStatus{
    case playing
    case win
    case draw
}

enum TicTacToePlayError: Error {
    case notValidSelection(message: String)
}
