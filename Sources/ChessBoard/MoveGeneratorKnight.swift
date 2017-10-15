//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public class MoveGeneratorKnight: MoveGenerator {
    
    //TODO: struct?
    private class Cache {
        
        static let moves: [BitBoard] = {
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
            return moves
        }()
    }
    
    func attacks(board: ChessBoard, color: Piece.Color) -> BitBoard {
        var pieces = board.piecesToMove.knight
        if pieces == .empty {
            return .empty
        }
        
        var attacks: BitBoard = .empty
        while pieces != .empty {
            attacks = Cache.moves[pieces.bitPop().rawValue]
        }
        
        return attacks
    }
    
    func moves(board: ChessBoard) -> [Move] {
        var result  = [Move]()
        let piece   = board.nextMove == .white ? Piece.whiteKnight : Piece.blackKnight

        var pieces = board.piecesToMove.knight
        while pieces != .empty {

            let sourceIndex = pieces.bitPop()
            var moves: BitBoard = Cache.moves[sourceIndex.rawValue] & board.emptyOrOpponent

            while moves != .empty {
                let targetIndex = moves.bitPop()
                
                let isCapture = (targetIndex.bitBoard & board.opponentPieces) != 0
                result.append(Move(piece: piece, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: nil))
            }
        }
        
        return result
    }
}


