//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by admin on 21/06/2021.
//

import XCTest
@testable import TicTacToe

class TicTacToeTests: XCTestCase {

    var sut: TicTacToeGame!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TicTacToeGame()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testInit() {
        let positions = [String]()
        let isFirstPlayer = true
        let gameStatus = GameState.playing
        
        XCTAssertEqual(sut.positions, positions)
        XCTAssertEqual(sut.isFirstPlayer, isFirstPlayer)
        XCTAssertEqual(sut.gameStatus, gameStatus)
    }
    
    func testReset() {
        let positions = [String](repeating: "", count: 9)
        let isFirstPlayer = true
        let gameStatus = GameState.playing
        
        XCTAssertNoThrow(sut.resetValues())
        XCTAssertEqual(sut.positions, positions)
        XCTAssertEqual(sut.isFirstPlayer, isFirstPlayer)
        XCTAssertEqual(sut.gameStatus, gameStatus)
    }
    
    func testPlayTurn() {
        sut.resetValues()
        sut.positions = ["", "", "", "", "", "", "", "", "" ]
        XCTAssertNoThrow(try sut.playTurn(position: 0))
    }
    
    func testPlayTurnFail() {
        sut.resetValues()
        sut.positions = ["X", "", "", "", "", "", "", "", "" ]
        XCTAssertThrowsError(try sut.playTurn(position: 0))
    }
    
    func testPlayTurnWinHorizontal() {
        sut.resetValues()
        sut.positions = ["X", "X", "", "", "", "", "", "", "" ]
        let statusFirstRow = try! sut.playTurn(position: 2)
        
        sut.resetValues()
        sut.positions = ["", "", "", "X", "X", "", "", "", "" ]
        let statusSecondRow = try! sut.playTurn(position: 5)
        
        sut.resetValues()
        sut.positions = ["", "", "", "", "", "", "X", "X", "" ]
        let statusThirdRow = try! sut.playTurn(position: 8)
        
        XCTAssertEqual(statusFirstRow, GameState.win)
        XCTAssertEqual(statusSecondRow, GameState.win)
        XCTAssertEqual(statusThirdRow, GameState.win)
    }
    
    func testPlayTurnWinVertical() {
        sut.resetValues()
        sut.positions = ["X", "", "", "X", "", "", "", "", "" ]
        let statusFirstColumn = try! sut.playTurn(position: 6)
        
        sut.resetValues()
        sut.positions = ["", "X", "", "", "X", "", "", "", "" ]
        let statusSecondColumn = try! sut.playTurn(position: 7)
        
        sut.resetValues()
        sut.positions = ["", "", "X", "", "", "X", "", "", "" ]
        let statusThirdColumn = try! sut.playTurn(position: 8)
        
        XCTAssertEqual(statusFirstColumn, GameState.win)
        XCTAssertEqual(statusSecondColumn, GameState.win)
        XCTAssertEqual(statusThirdColumn, GameState.win)
    }
    
    func testPlayTurnWinDiagonal() {
        sut.resetValues()
        sut.positions = ["X", "", "", "", "X", "", "", "", "" ]
        let statusFirstDiagonal = try! sut.playTurn(position: 8)
        
        sut.resetValues()
        sut.positions = ["", "", "X", "", "X", "", "", "", "" ]
        let statusSecondDiagonal = try! sut.playTurn(position: 6)
        
        XCTAssertEqual(statusFirstDiagonal, GameState.win)
        XCTAssertEqual(statusSecondDiagonal, GameState.win)
    }
    
    func testPlayTurnDraw() {
        sut.resetValues()
        sut.positions = ["", "O", "X", "X", "O", "O", "O", "X", "X" ]
        let status = try! sut.playTurn(position: 0)
        XCTAssertEqual(status, GameState.draw)
    }
    
    func testSecondPlayerTurn() {
        sut.resetValues()
        sut.positions = ["", "", "", "", "", "", "", "", "" ]
        var status = try! sut.playTurn(position: 0)
        status = try! sut.playTurn(position: 1)
        XCTAssertEqual(status, GameState.playing)
    }

}
