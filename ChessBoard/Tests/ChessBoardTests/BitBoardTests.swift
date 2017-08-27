import XCTest
@testable import ChessBoard

class BitBoardTests: XCTestCase {

    func assertBoardLooksLike(_ board: BitBoard, string: () -> String) {
        XCTAssertEqual(
            board.stringBoard.trimmingCharacters(in: .whitespacesAndNewlines),
            string().trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    func testA8H1() {
        assertBoardLooksLike(BitBoard.a8h1[0]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 x - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[1]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 x - - - - - - - 2
            1 - x - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[2]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 x - - - - - - - 3
            2 - x - - - - - - 2
            1 - - x - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[3]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 x - - - - - - - 4
            3 - x - - - - - - 3
            2 - - x - - - - - 2
            1 - - - x - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[4]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 x - - - - - - - 5
            4 - x - - - - - - 4
            3 - - x - - - - - 3
            2 - - - x - - - - 2
            1 - - - - x - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[5]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 x - - - - - - - 6
            5 - x - - - - - - 5
            4 - - x - - - - - 4
            3 - - - x - - - - 3
            2 - - - - x - - - 2
            1 - - - - - x - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[6]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 x - - - - - - - 7
            6 - x - - - - - - 6
            5 - - x - - - - - 5
            4 - - - x - - - - 4
            3 - - - - x - - - 3
            2 - - - - - x - - 2
            1 - - - - - - x - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[7]) {
            """
              a b c d e f g h
            8 x - - - - - - - 8
            7 - x - - - - - - 7
            6 - - x - - - - - 6
            5 - - - x - - - - 5
            4 - - - - x - - - 4
            3 - - - - - x - - 3
            2 - - - - - - x - 2
            1 - - - - - - - x 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[8]) {
            """
              a b c d e f g h
            8 - x - - - - - - 8
            7 - - x - - - - - 7
            6 - - - x - - - - 6
            5 - - - - x - - - 5
            4 - - - - - x - - 4
            3 - - - - - - x - 3
            2 - - - - - - - x 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[9]) {
            """
              a b c d e f g h
            8 - - x - - - - - 8
            7 - - - x - - - - 7
            6 - - - - x - - - 6
            5 - - - - - x - - 5
            4 - - - - - - x - 4
            3 - - - - - - - x 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[10]) {
            """
              a b c d e f g h
            8 - - - x - - - - 8
            7 - - - - x - - - 7
            6 - - - - - x - - 6
            5 - - - - - - x - 5
            4 - - - - - - - x 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[11]) {
            """
              a b c d e f g h
            8 - - - - x - - - 8
            7 - - - - - x - - 7
            6 - - - - - - x - 6
            5 - - - - - - - x 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[12]) {
            """
              a b c d e f g h
            8 - - - - - x - - 8
            7 - - - - - - x - 7
            6 - - - - - - - x 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[13]) {
            """
              a b c d e f g h
            8 - - - - - - x - 8
            7 - - - - - - - x 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a8h1[14]) {
            """
              a b c d e f g h
            8 - - - - - - - x 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }

        
    }
        
    func testA1H8() {

        assertBoardLooksLike(BitBoard.a1h8[0]) {
            """
              a b c d e f g h
            8 x - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }

        assertBoardLooksLike(BitBoard.a1h8[1]) {
            """
              a b c d e f g h
            8 - x - - - - - - 8
            7 x - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[2]) {
            """
              a b c d e f g h
            8 - - x - - - - - 8
            7 - x - - - - - - 7
            6 x - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[3]) {
            """
              a b c d e f g h
            8 - - - x - - - - 8
            7 - - x - - - - - 7
            6 - x - - - - - - 6
            5 x - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[4]) {
            """
              a b c d e f g h
            8 - - - - x - - - 8
            7 - - - x - - - - 7
            6 - - x - - - - - 6
            5 - x - - - - - - 5
            4 x - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[5]) {
            """
              a b c d e f g h
            8 - - - - - x - - 8
            7 - - - - x - - - 7
            6 - - - x - - - - 6
            5 - - x - - - - - 5
            4 - x - - - - - - 4
            3 x - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[6]) {
            """
              a b c d e f g h
            8 - - - - - - x - 8
            7 - - - - - x - - 7
            6 - - - - x - - - 6
            5 - - - x - - - - 5
            4 - - x - - - - - 4
            3 - x - - - - - - 3
            2 x - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[7]) {
            """
              a b c d e f g h
            8 - - - - - - - x 8
            7 - - - - - - x - 7
            6 - - - - - x - - 6
            5 - - - - x - - - 5
            4 - - - x - - - - 4
            3 - - x - - - - - 3
            2 - x - - - - - - 2
            1 x - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[8]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - x 7
            6 - - - - - - x - 6
            5 - - - - - x - - 5
            4 - - - - x - - - 4
            3 - - - x - - - - 3
            2 - - x - - - - - 2
            1 - x - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[9]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - x 6
            5 - - - - - - x - 5
            4 - - - - - x - - 4
            3 - - - - x - - - 3
            2 - - - x - - - - 2
            1 - - x - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[10]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - x 5
            4 - - - - - - x - 4
            3 - - - - - x - - 3
            2 - - - - x - - - 2
            1 - - - x - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[11]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - x 4
            3 - - - - - - x - 3
            2 - - - - - x - - 2
            1 - - - - x - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[12]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - x 3
            2 - - - - - - x - 2
            1 - - - - - x - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[13]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - x 2
            1 - - - - - - x - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.a1h8[14]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - x 1
              a b c d e f g h
            """
        }

    }
    
    func testFile() {
        assertBoardLooksLike(BitBoard.file[0]) {
            """
              a b c d e f g h
            8 x - - - - - - - 8
            7 x - - - - - - - 7
            6 x - - - - - - - 6
            5 x - - - - - - - 5
            4 x - - - - - - - 4
            3 x - - - - - - - 3
            2 x - - - - - - - 2
            1 x - - - - - - - 1
              a b c d e f g h
            """
        }
        
        assertBoardLooksLike(BitBoard.file[1]) {
            """
              a b c d e f g h
            8 - x - - - - - - 8
            7 - x - - - - - - 7
            6 - x - - - - - - 6
            5 - x - - - - - - 5
            4 - x - - - - - - 4
            3 - x - - - - - - 3
            2 - x - - - - - - 2
            1 - x - - - - - - 1
              a b c d e f g h
            """
        }
        
        assertBoardLooksLike(BitBoard.file[2]) {
            """
              a b c d e f g h
            8 - - x - - - - - 8
            7 - - x - - - - - 7
            6 - - x - - - - - 6
            5 - - x - - - - - 5
            4 - - x - - - - - 4
            3 - - x - - - - - 3
            2 - - x - - - - - 2
            1 - - x - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.file[3]) {
            """
              a b c d e f g h
            8 - - - x - - - - 8
            7 - - - x - - - - 7
            6 - - - x - - - - 6
            5 - - - x - - - - 5
            4 - - - x - - - - 4
            3 - - - x - - - - 3
            2 - - - x - - - - 2
            1 - - - x - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.file[4]) {
            """
              a b c d e f g h
            8 - - - - x - - - 8
            7 - - - - x - - - 7
            6 - - - - x - - - 6
            5 - - - - x - - - 5
            4 - - - - x - - - 4
            3 - - - - x - - - 3
            2 - - - - x - - - 2
            1 - - - - x - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.file[5]) {
            """
              a b c d e f g h
            8 - - - - - x - - 8
            7 - - - - - x - - 7
            6 - - - - - x - - 6
            5 - - - - - x - - 5
            4 - - - - - x - - 4
            3 - - - - - x - - 3
            2 - - - - - x - - 2
            1 - - - - - x - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.file[6]) {
            """
              a b c d e f g h
            8 - - - - - - x - 8
            7 - - - - - - x - 7
            6 - - - - - - x - 6
            5 - - - - - - x - 5
            4 - - - - - - x - 4
            3 - - - - - - x - 3
            2 - - - - - - x - 2
            1 - - - - - - x - 1
              a b c d e f g h
            """
        }
            
        assertBoardLooksLike(BitBoard.file[7]) {
            """
              a b c d e f g h
            8 - - - - - - - x 8
            7 - - - - - - - x 7
            6 - - - - - - - x 6
            5 - - - - - - - x 5
            4 - - - - - - - x 4
            3 - - - - - - - x 3
            2 - - - - - - - x 2
            1 - - - - - - - x 1
              a b c d e f g h
            """
        }
    }

    func testRank() {
        assertBoardLooksLike(BitBoard.rank[0]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 x x x x x x x x 1
              a b c d e f g h
            """
        }
        
        assertBoardLooksLike(BitBoard.rank[1]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 x x x x x x x x 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.rank[2]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 x x x x x x x x 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.rank[3]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 x x x x x x x x 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.rank[4]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 x x x x x x x x 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.rank[5]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 x x x x x x x x 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.rank[6]) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 x x x x x x x x 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        assertBoardLooksLike(BitBoard.rank[7]) {
            """
              a b c d e f g h
            8 x x x x x x x x 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
    }
    
    
    func testBasicMasks() {
        
        assertBoardLooksLike(BitBoard.frame) {
            """
              a b c d e f g h
            8 x x x x x x x x 8
            7 x - - - - - - x 7
            6 x - - - - - - x 6
            5 x - - - - - - x 5
            4 x - - - - - - x 4
            3 x - - - - - - x 3
            2 x - - - - - - x 2
            1 x x x x x x x x 1
              a b c d e f g h
            """
        }
        
        
        assertBoardLooksLike(BitBoard.universe) {
            """
              a b c d e f g h
            8 x x x x x x x x 8
            7 x x x x x x x x 7
            6 x x x x x x x x 6
            5 x x x x x x x x 5
            4 x x x x x x x x 4
            3 x x x x x x x x 3
            2 x x x x x x x x 2
            1 x x x x x x x x 1
              a b c d e f g h
            """
        }
        
        assertBoardLooksLike(BitBoard.empty) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
        
        assertBoardLooksLike(BitBoard.fileA) {
            """
              a b c d e f g h
            8 x - - - - - - - 8
            7 x - - - - - - - 7
            6 x - - - - - - - 6
            5 x - - - - - - - 5
            4 x - - - - - - - 4
            3 x - - - - - - - 3
            2 x - - - - - - - 2
            1 x - - - - - - - 1
              a b c d e f g h
            """
        }
        
        assertBoardLooksLike(BitBoard.fileH) {
            """
              a b c d e f g h
            8 - - - - - - - x 8
            7 - - - - - - - x 7
            6 - - - - - - - x 6
            5 - - - - - - - x 5
            4 - - - - - - - x 4
            3 - - - - - - - x 3
            2 - - - - - - - x 2
            1 - - - - - - - x 1
              a b c d e f g h
            """
        }
        
        
        assertBoardLooksLike(BitBoard.rank1) {
            """
              a b c d e f g h
            8 - - - - - - - - 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 x x x x x x x x 1
              a b c d e f g h
            """
        }

        assertBoardLooksLike(BitBoard.rank8) {
            """
              a b c d e f g h
            8 x x x x x x x x 8
            7 - - - - - - - - 7
            6 - - - - - - - - 6
            5 - - - - - - - - 5
            4 - - - - - - - - 4
            3 - - - - - - - - 3
            2 - - - - - - - - 2
            1 - - - - - - - - 1
              a b c d e f g h
            """
        }
    }
    
    func testFields() {
        assertBoardLooksLike(BitBoard.a1) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 x - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.b1) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - x - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.c1) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - x - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.d1) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - x - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.e1) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - x - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.f1) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - x - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.g1) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - x - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.h1) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - x 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.a2) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 x - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.b2) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - x - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.c2) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - x - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.d2) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - x - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.e2) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - x - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.f2) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - x - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.g2) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - x - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.h2) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - x 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.a3) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 x - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.b3) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - x - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.c3) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - x - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.d3) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - x - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.e3) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - x - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.f3) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - x - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.g3) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - x - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.h3) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - x 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.a4) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 x - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.b4) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - x - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.c4) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - x - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.d4) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - x - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.e4) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - x - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.f4) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - x - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.g4) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - x - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.h4) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - x 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.a5) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 x - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.b5) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - x - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.c5) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - x - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.d5) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - x - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.e5) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - x - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.f5) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - x - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.g5) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - x - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.h5) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - x 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.a6) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 x - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.b6) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - x - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.c6) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - x - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.d6) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - x - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.e6) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - x - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.f6) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - x - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.g6) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - x - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.h6) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - x 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.a7) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 x - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.b7) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - x - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.c7) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - x - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.d7) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - x - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.e7) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - x - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.f7) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - x - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.g7) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - x - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.h7) {
            """
      a b c d e f g h
    8 - - - - - - - - 8
    7 - - - - - - - x 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.a8) {
            """
      a b c d e f g h
    8 x - - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.b8) {
            """
      a b c d e f g h
    8 - x - - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.c8) {
            """
      a b c d e f g h
    8 - - x - - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.d8) {
            """
      a b c d e f g h
    8 - - - x - - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.e8) {
            """
      a b c d e f g h
    8 - - - - x - - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.f8) {
            """
      a b c d e f g h
    8 - - - - - x - - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.g8) {
            """
      a b c d e f g h
    8 - - - - - - x - 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
        assertBoardLooksLike(BitBoard.h8) {
            """
      a b c d e f g h
    8 - - - - - - - x 8
    7 - - - - - - - - 7
    6 - - - - - - - - 6
    5 - - - - - - - - 5
    4 - - - - - - - - 4
    3 - - - - - - - - 3
    2 - - - - - - - - 2
    1 - - - - - - - - 1
      a b c d e f g h
    """
        }
    }
}
