//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public class MoveGeneratorKing: MoveGenerator {
    
    let WHITE_OO_EMPTY:      BitBoard = .f1 | .g1
    let WHITE_OO_ATTACKS:    BitBoard = .e1 | .f1 | .g1
    let WHITE_OOO_EMPTY:     BitBoard = .b1 | .c1 | .d1
    let WHITE_OOO_ATTACKS:   BitBoard = .c1 | .d1 | .e1

    let BLACK_OO_EMPTY:      BitBoard = .f8 | .g8
    let BLACK_OO_ATTACKS:    BitBoard = .e8 | .f8 | .g8
    let BLACK_OOO_EMPTY:     BitBoard = .b8 | .c8 | .d8
    let BLACK_OOO_ATTACKS:   BitBoard = .c8 | .d8 | .e8

    //TODO: struct?
    class Cache {
        let moves: [BitBoard]
        
        init() {
            //TODO: magic constant 64
            var moves = [BitBoard](repeating: .empty, count: 64)
            
            for i in 0 ..< 64 {
                let piece = BitBoard.Index(rawValue: i)!.bitBoard
                
                moves[i] = piece.shift(dx: 1, dy: -1)   |
                    piece.shift(dx: 1, dy: 0)    |
                    piece.shift(dx: 1, dy: 1)    |
                    piece.shift(dx: 0, dy: -1)   |
                    piece.shift(dx: 0, dy: 1)    |
                    piece.shift(dx: -1, dy: -1)  |
                    piece.shift(dx: -1, dy: 0)   |
                    piece.shift(dx: -1, dy: 1)
            }
            
            self.moves = moves
        }
    }
    
    static let cache = Cache()
    
    func attacks(board: ChessBoard, color: ChessBoard.Color) -> BitBoard {
        let king = board.pieces[board.sideToMove][ChessBoard.Piece.king]
        if king == .empty {
            return .empty
        }
       
        assert(king.nonzeroBitCount == 1, "There can be only one king on the board.")
        
        //TODO PERFORMANCE: Test withnout cache
        return MoveGeneratorKing.cache.moves[king.trailingZeroBitCount]
    }
    
    func moves(board: ChessBoard) -> [Move] {
        var result  = [Move]()
        
        
        let kingBitBoard = board.pieces[board.sideToMove][ChessBoard.Piece.king]
        
        if kingBitBoard == .empty {
            return result
        }

        assert(kingBitBoard.nonzeroBitCount == 1, "There can be only one king on the board.")

        let sourceIndex = BitBoard.Index(rawValue: kingBitBoard.trailingZeroBitCount)!
        var moves = MoveGeneratorKing.cache.moves[sourceIndex] & board.emptyOrOpponentPiecesBoard
        while moves != .empty {
            let targetIndex = moves.bitPop()

            let isCapture = (targetIndex.bitBoard & board.emptyOrOpponentPiecesBoard) != 0
            result.append(Move(piece: ChessBoard.Piece.king, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: nil))
        }

        //castling
        if board.sideToMove == .white {
            if  board.castlingOptions[board.sideToMove][ChessBoard.Piece.king]    &&
                (board.allPiecesBoard & WHITE_OO_EMPTY == 0)   &&
                !board.isBitmaskUnderAttack(color: .black, board: WHITE_OO_ATTACKS)
            {
                result.append(Move(piece: ChessBoard.Piece.king, from: sourceIndex, to: .g1, isCapture: false, isEnpassant: false, promotionPiece: nil))
            }
            if  board.castlingOptions[board.sideToMove][ChessBoard.Piece.queen]    &&
                (board.allPiecesBoard & WHITE_OOO_EMPTY == 0)   &&
                !board.isBitmaskUnderAttack(color: .black, board: WHITE_OOO_ATTACKS)
            {
                result.append(Move(piece: ChessBoard.Piece.king, from: sourceIndex, to: .c1, isCapture: false, isEnpassant: false, promotionPiece: nil))
            }
        } else {
            if  board.castlingOptions[board.sideToMove][ChessBoard.Piece.king]    &&
                (board.allPiecesBoard & BLACK_OO_EMPTY == 0)   &&
                !board.isBitmaskUnderAttack(color: .white, board: BLACK_OO_ATTACKS)
            {
                result.append(Move(piece: ChessBoard.Piece.king, from: sourceIndex, to: .g8, isCapture: false, isEnpassant: false, promotionPiece: nil))
            }
            if  board.castlingOptions[board.sideToMove][ChessBoard.Piece.queen]    &&
                (board.allPiecesBoard & BLACK_OOO_EMPTY == 0)   &&
                !board.isBitmaskUnderAttack(color: .white, board: BLACK_OOO_ATTACKS)
            {
                result.append(Move(piece: ChessBoard.Piece.king, from: sourceIndex, to: .c8, isCapture: false, isEnpassant: false, promotionPiece: nil))
            }
        }
        
        return result
    }
}

