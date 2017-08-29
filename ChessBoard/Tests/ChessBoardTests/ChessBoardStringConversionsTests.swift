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
}
