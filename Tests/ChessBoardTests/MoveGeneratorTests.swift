//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import XCTest
@testable import ChessBoard

class MoveGeneratorTests: XCTestCase {
    
    func boardFrom(file: String) -> ChessBoard {
        let filePath = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("\(BitBoardTests.resourceFolder)/\(file).txt", isDirectory: false)
        var body = (try! String(contentsOf: filePath))
        body = body
            .replacingOccurrences(of: "[abcdefgh12345678]", with: "", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespaces).joined()
            .replacingOccurrences(of: "-", with: "1")
            .components(separatedBy: .newlines).joined(separator: "/")
        
        return ChessBoard(fenString: "\(body) w KQkq -")!
    }
    
    func numberOfMoves(file: String) -> Int {
        let board = boardFrom(file: file)
        return numberOfMoves(fen: board.fenString)
    }
    
    func numberOfMoves(fen: String) -> Int {
        let board = ChessBoard(fenString: fen)!

        return board.pseudoLegalMoves().count
    }
    
    func numberOfLegalMoves(file: String) -> UInt64 {
        let board = boardFrom(file: file)
        return board.perft(depth: 1)
    }

    func numberOfLegalMoves(fen: String) -> UInt64 {
        let board = ChessBoard(fenString: fen)!
        return board.perft(depth: 1)
    }
    
    func testPawns() {
        XCTAssertEqual(2, numberOfMoves(file: "moves-pawn-01"))
        XCTAssertEqual(0, numberOfMoves(file: "moves-pawn-02"))
        XCTAssertEqual(3, numberOfMoves(file: "moves-pawn-03"))
        XCTAssertEqual(4, numberOfMoves(file: "moves-pawn-04"))
        XCTAssertEqual(2, numberOfMoves(file: "moves-pawn-05"))
        XCTAssertEqual(12, numberOfMoves(file: "moves-pawn-06"))

        XCTAssertEqual(2, numberOfMoves(fen: "111n1n111/11111111/11n11pP1/11111111/11111111/11n1n1n1/11111111/11111111 w KQkq f7 0 1"))
    }

    func testKing() {
        XCTAssertEqual(8,   numberOfMoves(file:         "moves-king-01"))
        XCTAssertEqual(26,  numberOfMoves(file:         "moves-king-02"))
        XCTAssertEqual(24,  numberOfMoves(file:         "moves-king-03"))
        XCTAssertEqual(4,   numberOfLegalMoves(file:    "moves-king-04"))
        XCTAssertEqual(19,  numberOfMoves(file:         "moves-king-05"))
        XCTAssertEqual(1,   numberOfLegalMoves(file:    "moves-king-06"))
        XCTAssertEqual(0,   numberOfLegalMoves(file:    "moves-king-07"))
        XCTAssertEqual(18,  numberOfMoves(file:         "moves-king-08"))
        XCTAssertEqual(20,  numberOfMoves(file:         "moves-king-09"))
        XCTAssertEqual(19,  numberOfMoves(file:         "moves-king-10"))
        XCTAssertEqual(14,  numberOfMoves(file:         "moves-king-11"))
        XCTAssertEqual(15,  numberOfMoves(file:         "moves-king-12"))
        XCTAssertEqual(1,   numberOfLegalMoves(file:    "moves-king-13"))
    }
    
    func testNoKing() {
        let board = ChessBoard(fenString: "8/p7/8/8/8/8/7P/8 w - -")!
        XCTAssertEqual(2,   numberOfLegalMoves(fen:     board.fenString))
    }
    
    func testKnight() {
        XCTAssertEqual(6,   numberOfMoves(file:         "moves-knight-01"))
        XCTAssertEqual(14,  numberOfMoves(file:         "moves-knight-02"))
        XCTAssertEqual(23,  numberOfMoves(file:         "moves-knight-03"))
        XCTAssertEqual(1,   numberOfLegalMoves(file:    "moves-knight-04"))
        XCTAssertEqual(3,   numberOfLegalMoves(file:    "moves-knight-05"))
    }
    
    func testRook() {
        XCTAssertEqual(14,  numberOfMoves(file:         "moves-rook-01"))
        XCTAssertEqual(2,   numberOfMoves(file:         "moves-rook-02"))
        XCTAssertEqual(8,   numberOfMoves(file:         "moves-rook-03"))
        XCTAssertEqual(12,  numberOfMoves(file:         "moves-rook-04"))
        XCTAssertEqual(17,  numberOfMoves(file:         "moves-rook-05"))
        XCTAssertEqual(3,   numberOfMoves(file:         "moves-rook-06"))
        XCTAssertEqual(5,   numberOfMoves(file:         "moves-rook-07"))
        XCTAssertEqual(13,  numberOfMoves(file:         "moves-rook-08"))
    }
    
    func testBishop() {
        XCTAssertEqual(7,   numberOfMoves(file:         "moves-bishop-01"))
        XCTAssertEqual(13,  numberOfMoves(file:         "moves-bishop-02"))
        XCTAssertEqual(4,   numberOfMoves(file:         "moves-bishop-03"))
        XCTAssertEqual(4,   numberOfMoves(file:         "moves-bishop-04"))
        XCTAssertEqual(17,  numberOfMoves(file:         "moves-bishop-05"))
        XCTAssertEqual(7,   numberOfMoves(file:         "moves-bishop-06"))
        XCTAssertEqual(10,  numberOfMoves(file:         "moves-bishop-07"))
    }
    
    func testPerfT() {
  
//        measure {
            XCTAssertEqual(4865609, ChessBoard.standard.perft(depth: 5))
//        }
        
        
//        for (fen, depth, result) in [
//            ("r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1", 5, 193690690),
//            ("8/2p5/3p4/KP5r/1R3p1k/8/4P1P1/8 w - - 0 1", 4, 43238),
//            ("r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1 w kq - 0 1", 5, 15833292),
//            ("r2q1rk1/pP1p2pp/Q4n2/bbp1p3/Np6/1B3NBn/pPPP1PPP/R3K2R b KQ - 0 1", 4, 422333),
//            ("rnbqkb1r/pp1p1ppp/2p5/4P3/2B5/8/PPP1NnPP/RNBQK2R w KQkq - 0 6", 3, 53392),
//            ("r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10", 5, UInt64(164075551)),
//        ] {
//            let board = ChessBoard(fenString: fen)!
//            XCTAssertEqual(UInt64(result), ChessBoard.standard.perft(depth: depth))
//        }
    }
    
    //TODO: test zobrist!
}

