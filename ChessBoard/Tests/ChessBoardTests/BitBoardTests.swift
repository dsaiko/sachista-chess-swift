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
        for i in 1..<64 {
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
}
