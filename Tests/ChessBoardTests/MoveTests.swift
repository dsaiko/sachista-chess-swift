//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import XCTest
@testable import ChessBoard

class MoveTests: XCTestCase {
 
    func testMove() {
        XCTAssertEqual("\(Move(piece: ChessBoard.Piece.pawn, from: .a2, to: .a3))", "a2a3")
        XCTAssertEqual("\(Move(piece: ChessBoard.Piece.pawn, from: .a7, to: .b8, isCapture: true, promotionPiece: ChessBoard.Piece.queen))", "a7b8q")
    }
}

