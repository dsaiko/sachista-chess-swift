//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import XCTest
@testable import ChessBoard

class BitBoardIndexTests: XCTestCase {
    
    func testIndeces() {
        let all = [
            BitBoard.Index.a1, BitBoard.Index.b1, BitBoard.Index.c1, BitBoard.Index.d1, BitBoard.Index.e1, BitBoard.Index.f1, BitBoard.Index.g1, BitBoard.Index.h1,
            BitBoard.Index.a2, BitBoard.Index.b2, BitBoard.Index.c2, BitBoard.Index.d2, BitBoard.Index.e2, BitBoard.Index.f2, BitBoard.Index.g2, BitBoard.Index.h2,
            BitBoard.Index.a3, BitBoard.Index.b3, BitBoard.Index.c3, BitBoard.Index.d3, BitBoard.Index.e3, BitBoard.Index.f3, BitBoard.Index.g3, BitBoard.Index.h3,
            BitBoard.Index.a4, BitBoard.Index.b4, BitBoard.Index.c4, BitBoard.Index.d4, BitBoard.Index.e4, BitBoard.Index.f4, BitBoard.Index.g4, BitBoard.Index.h4,
            BitBoard.Index.a5, BitBoard.Index.b5, BitBoard.Index.c5, BitBoard.Index.d5, BitBoard.Index.e5, BitBoard.Index.f5, BitBoard.Index.g5, BitBoard.Index.h5,
            BitBoard.Index.a6, BitBoard.Index.b6, BitBoard.Index.c6, BitBoard.Index.d6, BitBoard.Index.e6, BitBoard.Index.f6, BitBoard.Index.g6, BitBoard.Index.h6,
            BitBoard.Index.a7, BitBoard.Index.b7, BitBoard.Index.c7, BitBoard.Index.d7, BitBoard.Index.e7, BitBoard.Index.f7, BitBoard.Index.g7, BitBoard.Index.h7,
            BitBoard.Index.a8, BitBoard.Index.b8, BitBoard.Index.c8, BitBoard.Index.d8, BitBoard.Index.e8, BitBoard.Index.f8, BitBoard.Index.g8, BitBoard.Index.h8
        ]
        
        XCTAssertEqual(all[0].rawValue, 0)
        for i in 1 ..< BitBoard.bitWidth {
            XCTAssertEqual(all[i].rawValue, all[i-1].rawValue + 1)
        }
        
        XCTAssertEqual(BitBoard.Index.a1.bitBoard, BitBoard.a1)
        XCTAssertEqual(BitBoard.Index.b1.bitBoard, BitBoard.b1)
        XCTAssertEqual(BitBoard.Index.c1.bitBoard, BitBoard.c1)
        XCTAssertEqual(BitBoard.Index.d1.bitBoard, BitBoard.d1)
        XCTAssertEqual(BitBoard.Index.e1.bitBoard, BitBoard.e1)
        XCTAssertEqual(BitBoard.Index.f1.bitBoard, BitBoard.f1)
        XCTAssertEqual(BitBoard.Index.g1.bitBoard, BitBoard.g1)
        XCTAssertEqual(BitBoard.Index.h1.bitBoard, BitBoard.h1)
        XCTAssertEqual(BitBoard.Index.a2.bitBoard, BitBoard.a2)
        XCTAssertEqual(BitBoard.Index.b2.bitBoard, BitBoard.b2)
        XCTAssertEqual(BitBoard.Index.c2.bitBoard, BitBoard.c2)
        XCTAssertEqual(BitBoard.Index.d2.bitBoard, BitBoard.d2)
        XCTAssertEqual(BitBoard.Index.e2.bitBoard, BitBoard.e2)
        XCTAssertEqual(BitBoard.Index.f2.bitBoard, BitBoard.f2)
        XCTAssertEqual(BitBoard.Index.g2.bitBoard, BitBoard.g2)
        XCTAssertEqual(BitBoard.Index.h2.bitBoard, BitBoard.h2)
        XCTAssertEqual(BitBoard.Index.a3.bitBoard, BitBoard.a3)
        XCTAssertEqual(BitBoard.Index.b3.bitBoard, BitBoard.b3)
        XCTAssertEqual(BitBoard.Index.c3.bitBoard, BitBoard.c3)
        XCTAssertEqual(BitBoard.Index.d3.bitBoard, BitBoard.d3)
        XCTAssertEqual(BitBoard.Index.e3.bitBoard, BitBoard.e3)
        XCTAssertEqual(BitBoard.Index.f3.bitBoard, BitBoard.f3)
        XCTAssertEqual(BitBoard.Index.g3.bitBoard, BitBoard.g3)
        XCTAssertEqual(BitBoard.Index.h3.bitBoard, BitBoard.h3)
        XCTAssertEqual(BitBoard.Index.a4.bitBoard, BitBoard.a4)
        XCTAssertEqual(BitBoard.Index.b4.bitBoard, BitBoard.b4)
        XCTAssertEqual(BitBoard.Index.c4.bitBoard, BitBoard.c4)
        XCTAssertEqual(BitBoard.Index.d4.bitBoard, BitBoard.d4)
        XCTAssertEqual(BitBoard.Index.e4.bitBoard, BitBoard.e4)
        XCTAssertEqual(BitBoard.Index.f4.bitBoard, BitBoard.f4)
        XCTAssertEqual(BitBoard.Index.g4.bitBoard, BitBoard.g4)
        XCTAssertEqual(BitBoard.Index.h4.bitBoard, BitBoard.h4)
        XCTAssertEqual(BitBoard.Index.a5.bitBoard, BitBoard.a5)
        XCTAssertEqual(BitBoard.Index.b5.bitBoard, BitBoard.b5)
        XCTAssertEqual(BitBoard.Index.c5.bitBoard, BitBoard.c5)
        XCTAssertEqual(BitBoard.Index.d5.bitBoard, BitBoard.d5)
        XCTAssertEqual(BitBoard.Index.e5.bitBoard, BitBoard.e5)
        XCTAssertEqual(BitBoard.Index.f5.bitBoard, BitBoard.f5)
        XCTAssertEqual(BitBoard.Index.g5.bitBoard, BitBoard.g5)
        XCTAssertEqual(BitBoard.Index.h5.bitBoard, BitBoard.h5)
        XCTAssertEqual(BitBoard.Index.a6.bitBoard, BitBoard.a6)
        XCTAssertEqual(BitBoard.Index.b6.bitBoard, BitBoard.b6)
        XCTAssertEqual(BitBoard.Index.c6.bitBoard, BitBoard.c6)
        XCTAssertEqual(BitBoard.Index.d6.bitBoard, BitBoard.d6)
        XCTAssertEqual(BitBoard.Index.e6.bitBoard, BitBoard.e6)
        XCTAssertEqual(BitBoard.Index.f6.bitBoard, BitBoard.f6)
        XCTAssertEqual(BitBoard.Index.g6.bitBoard, BitBoard.g6)
        XCTAssertEqual(BitBoard.Index.h6.bitBoard, BitBoard.h6)
        XCTAssertEqual(BitBoard.Index.a7.bitBoard, BitBoard.a7)
        XCTAssertEqual(BitBoard.Index.b7.bitBoard, BitBoard.b7)
        XCTAssertEqual(BitBoard.Index.c7.bitBoard, BitBoard.c7)
        XCTAssertEqual(BitBoard.Index.d7.bitBoard, BitBoard.d7)
        XCTAssertEqual(BitBoard.Index.e7.bitBoard, BitBoard.e7)
        XCTAssertEqual(BitBoard.Index.f7.bitBoard, BitBoard.f7)
        XCTAssertEqual(BitBoard.Index.g7.bitBoard, BitBoard.g7)
        XCTAssertEqual(BitBoard.Index.h7.bitBoard, BitBoard.h7)
        XCTAssertEqual(BitBoard.Index.a8.bitBoard, BitBoard.a8)
        XCTAssertEqual(BitBoard.Index.b8.bitBoard, BitBoard.b8)
        XCTAssertEqual(BitBoard.Index.c8.bitBoard, BitBoard.c8)
        XCTAssertEqual(BitBoard.Index.d8.bitBoard, BitBoard.d8)
        XCTAssertEqual(BitBoard.Index.e8.bitBoard, BitBoard.e8)
        XCTAssertEqual(BitBoard.Index.f8.bitBoard, BitBoard.f8)
        XCTAssertEqual(BitBoard.Index.g8.bitBoard, BitBoard.g8)
        XCTAssertEqual(BitBoard.Index.h8.bitBoard, BitBoard.h8)
    }
    
    func testFileIndex() {
        XCTAssertEqual(BitBoard.Index.a1.fileIndex, 0)
        XCTAssertEqual(BitBoard.Index.a8.fileIndex, 0)
        XCTAssertEqual(BitBoard.Index.h1.fileIndex, 7)
        XCTAssertEqual(BitBoard.Index.h8.fileIndex, 7)
    }
    
    func testRankIndex() {
        XCTAssertEqual(BitBoard.Index.a1.rankIndex, 0)
        XCTAssertEqual(BitBoard.Index.a8.rankIndex, 7)
        XCTAssertEqual(BitBoard.Index.h1.rankIndex, 0)
        XCTAssertEqual(BitBoard.Index.h8.rankIndex, 7)
    }
    
    func testIndexByNotation() {
        XCTAssertEqual(BitBoard.Index(notation: "a1"), BitBoard.Index.a1)
        XCTAssertEqual(BitBoard.Index(notation: "h8"), BitBoard.Index.h8)
        XCTAssertNil(BitBoard.Index(notation: "xx"))
    }
    
    func testIndexDescription() {
        XCTAssertEqual("\(BitBoard.Index.a1)", "a1")
        XCTAssertEqual("\(BitBoard.Index.h8)", "h8")
        XCTAssertEqual(BitBoard.Index.f4.description, "f4")
        XCTAssertEqual(BitBoard.Index.h4.description, "h4")
    }
}
