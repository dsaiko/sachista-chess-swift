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

        return ChessBoard(fenString: "\(body) w - -")!
    }
    
    func numberOfMoves(file: String) -> Int {
        let board = boardFrom(file: file)
        return numberOfMoves(fen: board.fenString)
    }

    func numberOfMoves(fen: String) -> Int {
        let board = ChessBoard(fenString: fen)!
        
        return MoveGeneratorPawn().moves(board: board).count
    }

}
