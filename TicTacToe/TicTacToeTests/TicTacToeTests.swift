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
        let gameStatus = GameStatus.playing
        
        XCTAssertEqual(sut.positions, positions)
        XCTAssertEqual(sut.isFirstPlayer, isFirstPlayer)
        XCTAssertEqual(sut.gameStatus, gameStatus)
    }
    
    func testReset() {
        let positions = [String](repeating: "", count: 9)
        let isFirstPlayer = true
        let gameStatus = GameStatus.playing
        
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
    
    func testPlayTurnWin() {
        sut.resetValues()
        sut.positions = ["X", "X", "", "O", "O", "X", "X", "X", "" ]
        let status = try! sut.playTurn(position: 2)
        XCTAssertEqual(status, GameStatus.win)
    }
    
    func testPlayTurnDraw() {
        sut.resetValues()
        sut.positions = ["", "O", "X", "X", "O", "O", "O", "X", "X" ]
        let status = try! sut.playTurn(position: 0)
        XCTAssertEqual(status, GameStatus.draw)
    }
    
    func testSecondPlayerTurn() {
        sut.resetValues()
        sut.positions = ["", "", "", "", "", "", "", "", "" ]
        var status = try! sut.playTurn(position: 0)
        status = try! sut.playTurn(position: 1)
        XCTAssertEqual(status, GameStatus.playing)
    }

}
