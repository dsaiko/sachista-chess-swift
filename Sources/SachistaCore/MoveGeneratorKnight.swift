//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

struct MoveGeneratorKnight: MoveGenerator {
    
    struct Cache {
        let moves: [BitBoard]
        
        init() {
            var moves = [BitBoard](repeating: .empty, count: 64)
            
            for i in 0 ..< 64 {
                let piece = BitBoard.Index(rawValue: i)!.bitBoard
                moves[i] =
                    piece.shift(dx: 2,  dy: 1)            |
                    piece.shift(dx: 2,  dy: -1)           |
                    piece.shift(dx: 1,  dy: 2)            |
                    piece.shift(dx: -1, dy: 2)            |
                    piece.shift(dx: -2, dy: 1)            |
                    piece.shift(dx: -2, dy: -1)           |
                    piece.shift(dx: -1, dy: -2)           |
                    piece.shift(dx: 1,  dy: -2)
            }
            self.moves = moves
        }
    }
    
    static let cache = Cache()
    
    func attacks(board: ChessBoard, color: ChessBoard.Color) -> BitBoard {
        var pieces = board.pieces[color][ChessBoard.Piece.knight]
        var attacks: BitBoard = .empty
        while pieces != .empty {
            attacks |= MoveGeneratorKnight.cache.moves[pieces.bitPop()]
        }
        
        return attacks
    }
    
    func moves(board: ChessBoard, result: inout [Move]) {

        var pieces = board.pieces[board.sideToMove][ChessBoard.Piece.knight]
        while pieces != .empty {

            let sourceIndex = pieces.bitPop()
            var moves: BitBoard = MoveGeneratorKnight.cache.moves[sourceIndex] & board.emptyOrOpponentPiecesBoard

            while moves != .empty {
                let targetIndex = moves.bitPop()
                result.append(Move(piece: ChessBoard.Piece.knight, from: sourceIndex, to: targetIndex, isEnpassant: false, promotionPiece: nil))
            }
        }
    }
}


