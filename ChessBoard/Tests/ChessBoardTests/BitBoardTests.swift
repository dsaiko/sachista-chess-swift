//  Created by Dusan Saiko (dusan@saiko.cz) on 22/08/2017.
//  Licensed under https://opensource.org/licenses/MIT

import XCTest
@testable import ChessBoard

extension BitBoard {
    
    func assertLooksLike(contentOf file: String) {
        let filePath = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("\(BitBoardTests.resourceFolder)/\(file).txt", isDirectory: false)
        let pattern = (try! String(contentsOf: filePath))
        
        XCTAssertEqual(
            self.stringBoard.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces).joined(),
            pattern.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces).joined()
        )
    }
}

class BitBoardTests: XCTestCase {

    static let resourceFolder = "resources"
    
    @inline(__always)
    func assertBoardLooksLike(_ board: BitBoard, string: () -> String) {
        XCTAssertEqual(
            board.stringBoard.trimmingCharacters(in: .whitespacesAndNewlines),
            string().trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    func testA8H1() {
        for i in 0..<15 {
            BitBoard.a8h1[i].assertLooksLike(contentOf: "a8h1-\(i)")
        }
    }
        
    func testA1H8() {
        for i in 0..<15 {
            BitBoard.a1h8[i].assertLooksLike(contentOf: "a1h8-\(i)")
        }
    }
    
    func testFile() {
        for i in 0..<8 {
            BitBoard.file[i].assertLooksLike(contentOf: "file-\(i)")
        }

        BitBoard.fileA.assertLooksLike(contentOf: "file-0")
        BitBoard.fileH.assertLooksLike(contentOf: "file-7")
    }

    func testRank() {
        for i in 0..<8 {
            BitBoard.rank[i].assertLooksLike(contentOf: "rank-\(i)")
        }

        BitBoard.rank1.assertLooksLike(contentOf: "rank-0")
        BitBoard.rank8.assertLooksLike(contentOf: "rank-7")
    }
    
    
    func testBasicMasks() {
        BitBoard.frame.assertLooksLike(contentOf: "frame")
        BitBoard.empty.assertLooksLike(contentOf: "empty")
        BitBoard.universe.assertLooksLike(contentOf: "universe")
    }
    
    func testFields() {
        BitBoard.a1.assertLooksLike(contentOf: "a1")
        BitBoard.b1.assertLooksLike(contentOf: "b1")
        BitBoard.c1.assertLooksLike(contentOf: "c1")
        BitBoard.d1.assertLooksLike(contentOf: "d1")
        BitBoard.e1.assertLooksLike(contentOf: "e1")
        BitBoard.f1.assertLooksLike(contentOf: "f1")
        BitBoard.g1.assertLooksLike(contentOf: "g1")
        BitBoard.h1.assertLooksLike(contentOf: "h1")
        BitBoard.a2.assertLooksLike(contentOf: "a2")
        BitBoard.b2.assertLooksLike(contentOf: "b2")
        BitBoard.c2.assertLooksLike(contentOf: "c2")
        BitBoard.d2.assertLooksLike(contentOf: "d2")
        BitBoard.e2.assertLooksLike(contentOf: "e2")
        BitBoard.f2.assertLooksLike(contentOf: "f2")
        BitBoard.g2.assertLooksLike(contentOf: "g2")
        BitBoard.h2.assertLooksLike(contentOf: "h2")
        BitBoard.a3.assertLooksLike(contentOf: "a3")
        BitBoard.b3.assertLooksLike(contentOf: "b3")
        BitBoard.c3.assertLooksLike(contentOf: "c3")
        BitBoard.d3.assertLooksLike(contentOf: "d3")
        BitBoard.e3.assertLooksLike(contentOf: "e3")
        BitBoard.f3.assertLooksLike(contentOf: "f3")
        BitBoard.g3.assertLooksLike(contentOf: "g3")
        BitBoard.h3.assertLooksLike(contentOf: "h3")
        BitBoard.a4.assertLooksLike(contentOf: "a4")
        BitBoard.b4.assertLooksLike(contentOf: "b4")
        BitBoard.c4.assertLooksLike(contentOf: "c4")
        BitBoard.d4.assertLooksLike(contentOf: "d4")
        BitBoard.e4.assertLooksLike(contentOf: "e4")
        BitBoard.f4.assertLooksLike(contentOf: "f4")
        BitBoard.g4.assertLooksLike(contentOf: "g4")
        BitBoard.h4.assertLooksLike(contentOf: "h4")
        BitBoard.a5.assertLooksLike(contentOf: "a5")
        BitBoard.b5.assertLooksLike(contentOf: "b5")
        BitBoard.c5.assertLooksLike(contentOf: "c5")
        BitBoard.d5.assertLooksLike(contentOf: "d5")
        BitBoard.e5.assertLooksLike(contentOf: "e5")
        BitBoard.f5.assertLooksLike(contentOf: "f5")
        BitBoard.g5.assertLooksLike(contentOf: "g5")
        BitBoard.h5.assertLooksLike(contentOf: "h5")
        BitBoard.a6.assertLooksLike(contentOf: "a6")
        BitBoard.b6.assertLooksLike(contentOf: "b6")
        BitBoard.c6.assertLooksLike(contentOf: "c6")
        BitBoard.d6.assertLooksLike(contentOf: "d6")
        BitBoard.e6.assertLooksLike(contentOf: "e6")
        BitBoard.f6.assertLooksLike(contentOf: "f6")
        BitBoard.g6.assertLooksLike(contentOf: "g6")
        BitBoard.h6.assertLooksLike(contentOf: "h6")
        BitBoard.a7.assertLooksLike(contentOf: "a7")
        BitBoard.b7.assertLooksLike(contentOf: "b7")
        BitBoard.c7.assertLooksLike(contentOf: "c7")
        BitBoard.d7.assertLooksLike(contentOf: "d7")
        BitBoard.e7.assertLooksLike(contentOf: "e7")
        BitBoard.f7.assertLooksLike(contentOf: "f7")
        BitBoard.g7.assertLooksLike(contentOf: "g7")
        BitBoard.h7.assertLooksLike(contentOf: "h7")
        BitBoard.a8.assertLooksLike(contentOf: "a8")
        BitBoard.b8.assertLooksLike(contentOf: "b8")
        BitBoard.c8.assertLooksLike(contentOf: "c8")
        BitBoard.d8.assertLooksLike(contentOf: "d8")
        BitBoard.e8.assertLooksLike(contentOf: "e8")
        BitBoard.f8.assertLooksLike(contentOf: "f8")
        BitBoard.g8.assertLooksLike(contentOf: "g8")
        BitBoard.h8.assertLooksLike(contentOf: "h8")
    }
    
}
