//  Created by Dusan Saiko (dusan@saiko.cz) on 22/08/2017.
//  Licensed under https://opensource.org/licenses/MIT

import XCTest
@testable import ChessBoard

class BitBoardOperationsTests: XCTestCase {
    
    func testOneWest() {
        XCTAssertEqual(BitBoard.a1.oneWest, BitBoard.empty)
        XCTAssertEqual(BitBoard.a8.oneWest, BitBoard.empty)
        XCTAssertEqual(BitBoard.h1.oneWest, BitBoard.g1)
        XCTAssertEqual(BitBoard.h8.oneWest, BitBoard.g8)
    }
    
    func testOneNorth() {
        XCTAssertEqual(BitBoard.a1.oneNorth, BitBoard.a2)
        XCTAssertEqual(BitBoard.a8.oneNorth, BitBoard.empty)
        XCTAssertEqual(BitBoard.h1.oneNorth, BitBoard.h2)
        XCTAssertEqual(BitBoard.h8.oneNorth, BitBoard.empty)
    }

    func testOneEast() {
        XCTAssertEqual(BitBoard.a1.oneEast, BitBoard.b1)
        XCTAssertEqual(BitBoard.a8.oneEast, BitBoard.b8)
        XCTAssertEqual(BitBoard.h1.oneEast, BitBoard.empty)
        XCTAssertEqual(BitBoard.h8.oneEast, BitBoard.empty)
    }

    func testOneSouth() {
        XCTAssertEqual(BitBoard.a1.oneSouth, BitBoard.empty)
        XCTAssertEqual(BitBoard.a8.oneSouth, BitBoard.a7)
        XCTAssertEqual(BitBoard.h1.oneSouth, BitBoard.empty)
        XCTAssertEqual(BitBoard.h8.oneSouth, BitBoard.h7)
    }

    func testOneSouthEast() {
        XCTAssertEqual(BitBoard.a1.oneSouthEast, BitBoard.empty)
        XCTAssertEqual(BitBoard.a8.oneSouthEast, BitBoard.b7)
        XCTAssertEqual(BitBoard.h1.oneSouthEast, BitBoard.empty)
        XCTAssertEqual(BitBoard.h8.oneSouthEast, BitBoard.empty)
    }

    func testOneSouthWest() {
        XCTAssertEqual(BitBoard.a1.oneSouthWest, BitBoard.empty)
        XCTAssertEqual(BitBoard.a8.oneSouthWest, BitBoard.empty)
        XCTAssertEqual(BitBoard.h1.oneSouthWest, BitBoard.empty)
        XCTAssertEqual(BitBoard.h8.oneSouthWest, BitBoard.g7)
    }

    func testOneNorthEast() {
        XCTAssertEqual(BitBoard.a1.oneNorthEast, BitBoard.b2)
        XCTAssertEqual(BitBoard.a8.oneNorthEast, BitBoard.empty)
        XCTAssertEqual(BitBoard.h1.oneNorthEast, BitBoard.empty)
        XCTAssertEqual(BitBoard.h8.oneNorthEast, BitBoard.empty)
    }
    
    func testOneNorthWest() {
        XCTAssertEqual(BitBoard.a1.oneNorthWest, BitBoard.empty)
        XCTAssertEqual(BitBoard.a8.oneNorthWest, BitBoard.empty)
        XCTAssertEqual(BitBoard.h1.oneNorthWest, BitBoard.g2)
        XCTAssertEqual(BitBoard.h8.oneNorthWest, BitBoard.empty)
    }
    
    func testFlipA1H8() {
        let diag1 = ~BitBoard.a1h8[7]
        let diag2 = ~BitBoard.a1h8[5]
        
        XCTAssertEqual(diag1.flipA1H8, diag1)
        XCTAssertEqual(diag2.flipA1H8.flipA1H8, diag2)
        XCTAssertNotEqual(diag2.flipA1H8, diag2)

        let b1 = BitBoard.a1 | BitBoard.h1 | BitBoard.h8
        let b2 = BitBoard.a1 | BitBoard.a8 | BitBoard.h8

        XCTAssertEqual(b1.flipA1H8, b2)
    }
    
    func testMirrorHorizontal() {
        let b2 = BitBoard.a1h8[7]

        XCTAssertEqual(BitBoard.frame.mirrorHorizontal, BitBoard.frame)
        XCTAssertEqual(b2.mirrorHorizontal.mirrorHorizontal, b2)
        XCTAssertNotEqual(b2.mirrorHorizontal, b2)

        XCTAssertEqual(BitBoard.file[1], BitBoard.file[6].mirrorHorizontal)
    }

}



