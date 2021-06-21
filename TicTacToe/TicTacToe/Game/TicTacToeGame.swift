//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by admin on 21/06/2021.
//

import Foundation

///Traditional Tic-Tac-Toe game
class TicTacToeGame{
    /// Possible moves that can be selected in the game
    var positions: [String] = []
    
    /// Possible moves that can be selected in the game
    var isFirstPlayer: Bool = true
    
    /// State of the game
    var gameStatus: GameState = .playing
    
    /// The player consumes his turn by selecting a position.
    ///
    /// - Parameter position: Position selected by the current player
    /// - Returns: Game state
    func playTurn(position: Int) throws -> GameState{
        guard positions[position].isEmpty else {
            throw TicTacToePlayError.notValidSelection(message: "This option is not valid.")
        }
        positions[position] = isFirstPlayer ? "X" : "O"
        isFirstPlayer = !isFirstPlayer
        return getGameState()
    }
    
    /// Check the current game status.
    ///
    /// - Returns: Game status
    private func getGameState() -> GameState {
        guard checkWin() else {
            return positions.contains("") ? .playing : .draw
        }
        return .win
    }
    
    /// Check if the current player wins the game.
    ///
    /// - Returns: True if the current player wins the game
    private func checkWin() -> Bool {
        return (
            (positions[0].isEqualTo(value: positions[1]) && positions[1].isEqualTo(value: positions[2])) ||
            (positions[3].isEqualTo(value: positions[4]) && positions[4].isEqualTo(value: positions[5])) ||
            (positions[6].isEqualTo(value: positions[7]) && positions[7].isEqualTo(value: positions[8])) ||
            (positions[0].isEqualTo(value: positions[3]) && positions[3].isEqualTo(value: positions[6])) ||
            (positions[1].isEqualTo(value: positions[4]) && positions[4].isEqualTo(value: positions[7])) ||
            (positions[2].isEqualTo(value: positions[5]) && positions[5].isEqualTo(value: positions[8])) ||
            (positions[0].isEqualTo(value: positions[4]) && positions[4].isEqualTo(value: positions[8])) ||
            (positions[2].isEqualTo(value: positions[4]) && positions[4].isEqualTo(value: positions[6]))
            )
    }
    
    /// Reset all the values to their initial state to start a new game
    func resetValues() {
        positions = [String](repeating: "", count: 9)
        isFirstPlayer = true
        gameStatus = .playing
    }
}

/// Possible game states
enum GameState{
    case playing
    case win
    case draw
}

/// Custom Tic-Tac-Toe error
enum TicTacToePlayError: Error {
    case notValidSelection(message: String)
}

/// Custom validation of the selected position
extension String{
    func isEqualTo(value: String) -> Bool {
        return self == value && !self.isEmpty
    }
}
