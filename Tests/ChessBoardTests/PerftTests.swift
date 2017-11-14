//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import XCTest
@testable import ChessBoard

class PerftTests: XCTestCase {

    func testPerfT() {
        XCTAssertEqual(4_865_609, ChessBoard.standard.perft1(depth: 5))
        XCTAssertEqual(674_624, ChessBoard(fenString: "8/2p5/3p4/KP5r/1R3p1k/8/4P1P1/8 w - -")!.perft1(depth: 5))
        XCTAssertEqual(15_833_292, ChessBoard(fenString: "r2q1rk1/pP1p2pp/Q4n2/bbp1p3/Np6/1B3NBn/pPPP1PPP/R3K2R b KQ - 0 1")!.perft1(depth: 5))
        XCTAssertEqual(164_075_551, ChessBoard(fenString: "r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1 w - - 0 10")!.perft1(depth: 5))
        XCTAssertEqual(15_833_292, ChessBoard(fenString: "r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1 w kq - 0 1")!.perft1(depth: 5))
        XCTAssertEqual(193_690_690, ChessBoard(fenString: "r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq -")!.perft1(depth: 5))
        XCTAssertEqual(89_941_194, ChessBoard(fenString: "rnbq1k1r/pp1Pbppp/2p5/8/2B5/8/PPP1NnPP/RNBQK2R w KQ - 1 8")!.perft1(depth: 5))
    }

//    func testPerftBugfix() {
//        print("------------------------------\n\n")
//        let fen = "R2q1rk1/p2p2pp/Q4n2/bb2p3/Npp5/1B3NBn/pPPP1PPP/R3K2R b KQ - 0 2"
//        let depth = 2
//
//        let board = ChessBoard(fenString: fen)!
//
//
//        print("Fent matches: \(fen == board.fenString)")
//        print()
//        for i in 1 ... depth {
//            print("Perft \(i): \(board.perft0(depth: i))")
//        }
//        print()
//
//        for move in board.pseudoLegalMoves() {
//            let newBoard = board.makeMove(move: move)
//            if !newBoard.isOpponentsKingUnderCheck() {
//                print(newBoard.fenString)
//                print("\(newBoard.perft0(depth: depth - 1))")
//                //print("\(move): \(newBoard.perft0(depth: depth - 1)): \(newBoard.fenString)")
//            }
//        }
//
//        print()
//        for move in board.pseudoLegalMoves() {
//            let newBoard = board.makeMove(move: move)
//            if !newBoard.isOpponentsKingUnderCheck() {
//                print("./perft \"\(newBoard.fenString)\" \(depth - 1)")
//            }
//        }
//
//        print("\n\n------------------------------\n\n")
//    }
}
