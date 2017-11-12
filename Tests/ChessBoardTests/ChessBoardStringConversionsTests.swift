//
//  ChessBoardStringConversionTests.swift
//  ChessBoardTests
//
//  Created by Saiko, Dusan: IT (PRG) on 29/08/2017.
//

import Foundation

import XCTest
@testable import ChessBoard

extension ChessBoard {
    
    func assertLooksLike(contentOf file: String) {
        let filePath = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("\(BitBoardTests.resourceFolder)/\(file).txt", isDirectory: false)
        let pattern = (try! String(contentsOf: filePath))
        
        XCTAssertEqual(
            self.description.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces).joined(),
            pattern.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces).joined()
        )
    }
}

class ChessBoardStringConversionsTests: XCTestCase {

    func testStandardBoard() {
        ChessBoard.standard.assertLooksLike(contentOf: "chessboard-standard")
        ChessBoard().assertLooksLike(contentOf: "chessboard-empty")
    }
    
    func testFenString() {
        XCTAssertEqual(ChessBoard.standard.fenString, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
        XCTAssertEqual(ChessBoard.standard.fenString, ChessBoard(fenString: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")?.fenString)
        
        
        //incomplete FEN
        var board = ChessBoard(fenString: "8/1K6/1Q6/8/5r2/4rk2/8/8 w - -")!
        XCTAssertEqual(5, board.allPiecesBoard.nonzeroBitCount)
        XCTAssertEqual(board.sideToMove, .white)
        XCTAssertFalse(board.castlingOptions[ChessBoard.Color.white][ChessBoard.Piece.king])
        XCTAssertFalse(board.castlingOptions[ChessBoard.Color.white][ChessBoard.Piece.queen])
        XCTAssertFalse(board.castlingOptions[ChessBoard.Color.black][ChessBoard.Piece.king])
        XCTAssertFalse(board.castlingOptions[ChessBoard.Color.black][ChessBoard.Piece.queen])
        XCTAssertEqual(0, board.halfMoveClock)
        XCTAssertEqual(1, board.fullMoveNumber)
        XCTAssertNil(board.enPassantTarget)
        
        
        board = ChessBoard(fenString: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQq a2 14 33")!
        XCTAssertEqual(32, board.allPiecesBoard.nonzeroBitCount)
        XCTAssertEqual(board.sideToMove, .black)
        XCTAssertTrue(board.castlingOptions[ChessBoard.Color.white][ChessBoard.Piece.king])
        XCTAssertTrue(board.castlingOptions[ChessBoard.Color.white][ChessBoard.Piece.queen])
        XCTAssertFalse(board.castlingOptions[ChessBoard.Color.black][ChessBoard.Piece.king])
        XCTAssertTrue(board.castlingOptions[ChessBoard.Color.black][ChessBoard.Piece.queen])
        XCTAssertEqual(14, board.halfMoveClock)
        XCTAssertEqual(33, board.fullMoveNumber)
        XCTAssertEqual(board.enPassantTarget, .a2)

        board = ChessBoard(fenString: "7B/6B1/5B2/4B3/3B4/2B5/1B6/B7 w - - 0 1")!
        XCTAssertEqual(board.allPiecesBoard, BitBoard.a1h8[7])

        XCTAssertNil(ChessBoard(fenString: "rnbqkbnr/pppppppp/9/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"))
        XCTAssertNil(ChessBoard(fenString: "rnbqkbCr/pppppppp/9/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"))
        XCTAssertNil(ChessBoard(fenString: "7B/6B1/5B2/4B3/3B4/2B5/1B6 w - - 0 1"))
        XCTAssertNil(ChessBoard(fenString: "w"))
        

        //test castling error correction
        XCTAssertEqual(ChessBoard(fenString: "1n6/8/4n3/8/5n2/1n1n4/3K4/8 w KQkq - 0 1")!.fenString, "1n6/8/4n3/8/5n2/1n1n4/3K4/8 w - - 0 1")
    }
}
