//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import XCTest
@testable import ChessBoard

class MoveTests: XCTestCase {
 
    func testMove() {
        XCTAssertEqual("\(Move(piece: .whitePawn, from: .a2, to: .a3))", "a2a3")
        XCTAssertEqual("\(Move(piece: .whitePawn, from: .a7, to: .b8, isCapture: true, promotionPiece: .whiteQueen))", "a7xb8q")
    }
}

