//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public class MoveGeneratorKing: MoveGenerator {
    
    let cachedMoves: [BitBoard]
    
    let WHITE_OO_EMPTY:      BitBoard = .f1 | .g1
    let WHITE_OO_ATTACKS:    BitBoard = .e1 | .f1 | .g1
    let WHITE_OOO_EMPTY:     BitBoard = .b1 | .c1 | .d1
    let WHITE_OOO_ATTACKS:   BitBoard = .c1 | .d1 | .e1

    let BLACK_OO_EMPTY:      BitBoard = .f8 | .g8
    let BLACK_OO_ATTACKS:    BitBoard = .e8 | .f8 | .g8
    let BLACK_OOO_EMPTY:     BitBoard = .b8 | .c8 | .d8
    let BLACK_OOO_ATTACKS:   BitBoard = .c8 | .d8 | .e8
    
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
        
        self.cachedMoves = moves
    }

    func attacks(board: ChessBoard, color: Piece.Color) -> BitBoard {
        let king = color == .white ? board.whitePieces.king : board.blackPieces.king
        if king == .empty {
            return .empty
        }
       
        assert(king.nonzeroBitCount == 1, "There can be only one king on the board.")
        //TODO PERFORMANCE: Test withnout cache
        return cachedMoves[king.trailingZeroBitCount]
    }
    
    func moves(board: ChessBoard) -> [Move] {
        var result  = [Move]()
        
        if board.kingBoard == .empty {
            return result
        }
        
        let sourceIndex = board.kingIndex
        
        var moves   = cachedMoves[sourceIndex.rawValue] & board.emptyOrOpponent
        //TODO PERFORMANCE: Is piece necessary in Move?
        let piece   = board.nextMove == .white ? Piece.whiteKing : Piece.blackKing

        //for all moves
        
        //transform to array of moves
        while moves != .empty {
            let targetIndex = moves.bitPop()

            let isCapture = (targetIndex.bitBoard & board.opponentPieces) != 0
            result.append(Move(piece: piece, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: nil))
        }

        //castling
        if board.nextMove == .white {
            if  (board.whiteCastlingOptions.isKingSideCastlingAvailable)    &&
                (board.allPieces & WHITE_OO_EMPTY == 0)   &&
                !board.isBitmaskUnderAttack(color: .black, board: WHITE_OO_ATTACKS)
            {
                result.append(Move(piece: piece, from: sourceIndex, to: .g1, isCapture: false, isEnpassant: false, promotionPiece: nil))
            }
            if  (board.whiteCastlingOptions.isQueenSideCastlingAvailable)    &&
                (board.allPieces & WHITE_OOO_EMPTY == 0)   &&
                !board.isBitmaskUnderAttack(color: .black, board: WHITE_OOO_ATTACKS)
            {
                result.append(Move(piece: piece, from: sourceIndex, to: .c1, isCapture: false, isEnpassant: false, promotionPiece: nil))
            }
        } else {
            if  (board.blackCastlingOptions.isKingSideCastlingAvailable)    &&
                (board.allPieces & BLACK_OO_EMPTY == 0)   &&
                !board.isBitmaskUnderAttack(color: .white, board: BLACK_OO_ATTACKS)
            {
                result.append(Move(piece: piece, from: sourceIndex, to: .g8, isCapture: false, isEnpassant: false, promotionPiece: nil))
            }
            if  (board.blackCastlingOptions.isQueenSideCastlingAvailable)    &&
                (board.allPieces & BLACK_OOO_EMPTY == 0)   &&
                !board.isBitmaskUnderAttack(color: .white, board: BLACK_OOO_ATTACKS)
            {
                result.append(Move(piece: piece, from: sourceIndex, to: .c8, isCapture: false, isEnpassant: false, promotionPiece: nil))
            }
        }
        
        return result
    }
}

