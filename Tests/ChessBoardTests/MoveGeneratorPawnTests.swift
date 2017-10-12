//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import XCTest
@testable import ChessBoard

class MoveGeneratorPawnTests: MoveGeneratorTests {
    
    func testMoves() {
        XCTAssertEqual(2, numberOfMoves(file: "moves-pawn-01"))
        XCTAssertEqual(0, numberOfMoves(file: "moves-pawn-02"))
        XCTAssertEqual(3, numberOfMoves(file: "moves-pawn-03"))
        XCTAssertEqual(4, numberOfMoves(file: "moves-pawn-04"))
        XCTAssertEqual(2, numberOfMoves(file: "moves-pawn-05"))
        XCTAssertEqual(12, numberOfMoves(file: "moves-pawn-06"))

        XCTAssertEqual(2, numberOfMoves(fen: "111n1n111/11111111/11n11pP1/11111111/11111111/11n1n1n1/11111111/11111111 w KQkq f7 0 1"))
    }
}

