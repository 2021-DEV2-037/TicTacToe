//
//  ViewController.swift
//  TicTacToe
//
//  Created by admin on 21/06/2021.
//

import UIKit

class ViewController: UIViewController {

    let ticTacToeGame = TicTacToeGame()
    var playedPositions = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ticTacToeGame.resetValues()
    }

    @IBAction func playTurn(_ sender: UIButton) {
        do{
            let currentPlayer = ticTacToeGame.getCurrentPlayer()
            let textColor = ticTacToeGame.isFirstPlayer ? UIColor.blue : UIColor.red
            let gameState = try ticTacToeGame.playTurn(position: sender.tag)
            sender.setTitle(currentPlayer, for: .normal)
            sender.setTitleColor(textColor, for: .normal)
            playedPositions.append(sender)
            if gameState != .playing {
                showAlert(title: "Game Over", text: gameState == .win ? "\(currentPlayer) WIN!!!" : "The game is a draw.", isError: false)
            }
        }catch TicTacToePlayError.notValidSelection(let message){
            showAlert(title: "Oops", text: message, isError: true)
        }catch{
            showAlert(title: "Error", text: "Unexpected error: \(error)", isError: true)
        }
    }
    
    private func showAlert(title: String, text: String, isError: Bool) -> Void {
        let alertMessage = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if !isError{
                self.ticTacToeGame.resetValues()
                for play in self.playedPositions{
                    play.isEnabled = true
                    play.setTitle("", for: .normal)
                }
                self.playedPositions.removeAll()
            }
        })
        alertMessage.addAction(okAction)
        self.present(alertMessage, animated: true, completion: nil)
    }
    
}

