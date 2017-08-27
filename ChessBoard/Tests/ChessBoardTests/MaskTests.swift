import XCTest
@testable import ChessBoard

class MaskTests: XCTestCase {

    func assertBoardLooksLike(_ board: UInt64, string: () -> String) {
        XCTAssertEqual(
            Board.toString(board: board).trimmingCharacters(in: .whitespacesAndNewlines),
            string().trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    func testA8H1() {
        assertBoardLooksLike(Mask.a8h1[0]) {
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
        assertBoardLooksLike(Mask.a8h1[1]) {
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
        assertBoardLooksLike(Mask.a8h1[2]) {
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
        assertBoardLooksLike(Mask.a8h1[3]) {
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
        assertBoardLooksLike(Mask.a8h1[4]) {
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
        assertBoardLooksLike(Mask.a8h1[5]) {
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
        assertBoardLooksLike(Mask.a8h1[6]) {
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
        assertBoardLooksLike(Mask.a8h1[7]) {
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
        assertBoardLooksLike(Mask.a8h1[8]) {
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
        assertBoardLooksLike(Mask.a8h1[9]) {
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
        assertBoardLooksLike(Mask.a8h1[10]) {
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
        assertBoardLooksLike(Mask.a8h1[11]) {
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
        assertBoardLooksLike(Mask.a8h1[12]) {
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
        assertBoardLooksLike(Mask.a8h1[13]) {
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
        assertBoardLooksLike(Mask.a8h1[14]) {
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

        assertBoardLooksLike(Mask.a1h8[0]) {
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

        assertBoardLooksLike(Mask.a1h8[1]) {
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
        assertBoardLooksLike(Mask.a1h8[2]) {
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
        assertBoardLooksLike(Mask.a1h8[3]) {
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
        assertBoardLooksLike(Mask.a1h8[4]) {
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
        assertBoardLooksLike(Mask.a1h8[5]) {
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
        assertBoardLooksLike(Mask.a1h8[6]) {
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
        assertBoardLooksLike(Mask.a1h8[7]) {
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
        assertBoardLooksLike(Mask.a1h8[8]) {
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
        assertBoardLooksLike(Mask.a1h8[9]) {
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
        assertBoardLooksLike(Mask.a1h8[10]) {
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
        assertBoardLooksLike(Mask.a1h8[11]) {
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
        assertBoardLooksLike(Mask.a1h8[12]) {
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
        assertBoardLooksLike(Mask.a1h8[13]) {
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
        assertBoardLooksLike(Mask.a1h8[14]) {
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
        assertBoardLooksLike(Mask.file[0]) {
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
        
        assertBoardLooksLike(Mask.file[1]) {
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
        
        assertBoardLooksLike(Mask.file[2]) {
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
        assertBoardLooksLike(Mask.file[3]) {
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
        assertBoardLooksLike(Mask.file[4]) {
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
        assertBoardLooksLike(Mask.file[5]) {
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
        assertBoardLooksLike(Mask.file[6]) {
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
            
        assertBoardLooksLike(Mask.file[7]) {
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
        assertBoardLooksLike(Mask.rank[0]) {
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
        
        assertBoardLooksLike(Mask.rank[1]) {
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
        assertBoardLooksLike(Mask.rank[2]) {
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
        assertBoardLooksLike(Mask.rank[3]) {
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
        assertBoardLooksLike(Mask.rank[4]) {
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
        assertBoardLooksLike(Mask.rank[5]) {
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
        assertBoardLooksLike(Mask.rank[6]) {
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
        assertBoardLooksLike(Mask.rank[7]) {
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
        
        assertBoardLooksLike(Mask.frame) {
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
        
        
        assertBoardLooksLike(Mask.universe) {
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
        
        assertBoardLooksLike(Mask.empty) {
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
        
        assertBoardLooksLike(Mask.fileA) {
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
        
        assertBoardLooksLike(Mask.fileH) {
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
        
        
        assertBoardLooksLike(Mask.rank1) {
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

        assertBoardLooksLike(Mask.rank8) {
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
        assertBoardLooksLike(Mask.a1) {
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
        assertBoardLooksLike(Mask.b1) {
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
        assertBoardLooksLike(Mask.c1) {
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
        assertBoardLooksLike(Mask.d1) {
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
        assertBoardLooksLike(Mask.e1) {
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
        assertBoardLooksLike(Mask.f1) {
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
        assertBoardLooksLike(Mask.g1) {
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
        assertBoardLooksLike(Mask.h1) {
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
        assertBoardLooksLike(Mask.a2) {
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
        assertBoardLooksLike(Mask.b2) {
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
        assertBoardLooksLike(Mask.c2) {
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
        assertBoardLooksLike(Mask.d2) {
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
        assertBoardLooksLike(Mask.e2) {
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
        assertBoardLooksLike(Mask.f2) {
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
        assertBoardLooksLike(Mask.g2) {
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
        assertBoardLooksLike(Mask.h2) {
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
        assertBoardLooksLike(Mask.a3) {
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
        assertBoardLooksLike(Mask.b3) {
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
        assertBoardLooksLike(Mask.c3) {
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
        assertBoardLooksLike(Mask.d3) {
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
        assertBoardLooksLike(Mask.e3) {
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
        assertBoardLooksLike(Mask.f3) {
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
        assertBoardLooksLike(Mask.g3) {
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
        assertBoardLooksLike(Mask.h3) {
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
        assertBoardLooksLike(Mask.a4) {
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
        assertBoardLooksLike(Mask.b4) {
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
        assertBoardLooksLike(Mask.c4) {
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
        assertBoardLooksLike(Mask.d4) {
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
        assertBoardLooksLike(Mask.e4) {
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
        assertBoardLooksLike(Mask.f4) {
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
        assertBoardLooksLike(Mask.g4) {
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
        assertBoardLooksLike(Mask.h4) {
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
        assertBoardLooksLike(Mask.a5) {
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
        assertBoardLooksLike(Mask.b5) {
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
        assertBoardLooksLike(Mask.c5) {
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
        assertBoardLooksLike(Mask.d5) {
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
        assertBoardLooksLike(Mask.e5) {
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
        assertBoardLooksLike(Mask.f5) {
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
        assertBoardLooksLike(Mask.g5) {
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
        assertBoardLooksLike(Mask.h5) {
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
        assertBoardLooksLike(Mask.a6) {
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
        assertBoardLooksLike(Mask.b6) {
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
        assertBoardLooksLike(Mask.c6) {
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
        assertBoardLooksLike(Mask.d6) {
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
        assertBoardLooksLike(Mask.e6) {
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
        assertBoardLooksLike(Mask.f6) {
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
        assertBoardLooksLike(Mask.g6) {
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
        assertBoardLooksLike(Mask.h6) {
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
        assertBoardLooksLike(Mask.a7) {
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
        assertBoardLooksLike(Mask.b7) {
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
        assertBoardLooksLike(Mask.c7) {
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
        assertBoardLooksLike(Mask.d7) {
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
        assertBoardLooksLike(Mask.e7) {
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
        assertBoardLooksLike(Mask.f7) {
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
        assertBoardLooksLike(Mask.g7) {
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
        assertBoardLooksLike(Mask.h7) {
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
        assertBoardLooksLike(Mask.a8) {
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
        assertBoardLooksLike(Mask.b8) {
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
        assertBoardLooksLike(Mask.c8) {
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
        assertBoardLooksLike(Mask.d8) {
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
        assertBoardLooksLike(Mask.e8) {
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
        assertBoardLooksLike(Mask.f8) {
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
        assertBoardLooksLike(Mask.g8) {
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
        assertBoardLooksLike(Mask.h8) {
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
