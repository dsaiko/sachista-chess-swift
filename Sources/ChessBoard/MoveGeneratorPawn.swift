//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public class MoveGeneratorPawn: MoveGenerator {
    
    //TODO: struct?
    class CachedMoves {
        let moves          : [BitBoard]
        let doubleMoves    : [BitBoard]
        let attacks        : [BitBoard]
        
        init(color: Piece.Color) {
            var moves          = [BitBoard](repeating: .empty, count: 64)
            var doubleMoves    = [BitBoard](repeating: .empty, count: 64)
            var attacks        = [BitBoard](repeating: .empty, count: 64)

            for i in 0 ..< 64 {
                let piece = BitBoard.Index(rawValue: i)!.bitBoard
                
                if color == .white {
                    moves[i]        = piece.shift(dx: 0, dy: 1)
                    doubleMoves[i]  = piece.shift(dx: 0, dy: 2)
                    attacks[i]      = piece.shift(dx: 1, dy: 1) | piece.shift(dx: -1, dy: 1)
                } else {
                    moves[i]        = piece.shift(dx: 0, dy: -1)
                    doubleMoves[i]  = piece.shift(dx: 0, dy: -2)
                    attacks[i]      = piece.shift(dx: 1, dy: -1) | piece.shift(dx: -1, dy: -1)
                }
            }
            
            self.moves = moves
            self.doubleMoves = doubleMoves
            self.attacks = attacks
        }
    }
        
    let cachedMovesWhite = CachedMoves(color: .white)
    let cachedMovesBlack = CachedMoves(color: .black)
    
    func attacks(board: ChessBoard, color: Piece.Color) -> BitBoard {
        //TODO PERFORMANCE: pregenerated??
        return color == .white ? (board.whitePieces.pawn.oneNorthEast | board.whitePieces.pawn.oneNorthWest) : (board.blackPieces.pawn.oneSouthEast | board.blackPieces.pawn.oneSouthWest)
    }
    
    func moves(board: ChessBoard) -> [Move] {
        let cache   = board.nextMove == .white ? cachedMovesWhite : cachedMovesBlack
        var pieces  = board.piecesToMove.pawn
        let piece   = board.nextMove == .white ? Piece.whitePawn : Piece.blackPawn
        var result  = [Move]()

        while pieces != .empty {
            let sourceIndex = pieces.bitPop()

            //one step forward if empty
            var moves: BitBoard = cache.moves[sourceIndex.rawValue] & board.emptyBoard
            
            //if one step forward was successful and we are on base rank, try double move
            //TODO PERFORMANCE: bitboard or one by one move?
            if moves != .empty {
                if board.nextMove == .white {
                    if sourceIndex <= .h2 {
                        moves |= moves.oneNorth & board.emptyBoard
                    }
                } else {
                    if sourceIndex >= .a7 {
                        moves |= moves.oneSouth & board.emptyBoard
                    }
                }
            }
            
            //add attacks
            let attacks = cache.attacks[sourceIndex.rawValue]
            moves |= attacks & board.opponentPieces
            
            //transform to array of moves
            while moves != .empty {
                let targetIndex = moves.bitPop()
                
                //TODO PERFORMANCE: what isCapture is used for?
                let isCapture = (targetIndex.bitBoard & board.opponentPieces) != 0
                let isPromotion = (board.nextMove == .white && targetIndex >= .a8) || (board.nextMove == .black && targetIndex <= .h1)

                //promotion?
                if isPromotion {
                    result.append(Move(piece: piece, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: board.nextMove == .white ? .whiteBishop  : .blackBishop))
                    result.append(Move(piece: piece, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: board.nextMove == .white ? .whiteKnight  : .blackKnight))
                    result.append(Move(piece: piece, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: board.nextMove == .white ? .whiteQueen   : .blackQueen))
                    result.append(Move(piece: piece, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: board.nextMove == .white ? .whiteRook    : .blackRook))
                } else {
                    //normal move/capture
                    result.append(Move(piece: piece, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: nil))
                }
            }
            
            //check enpassant capture
            //TODO PERFORMANCE: what isEnpassange is used for?
            if let enPassantTarget = board.enPassantTarget {
                moves = attacks & enPassantTarget.bitBoard
                if moves != .empty {
                    result.append(Move(piece: piece, from: sourceIndex, to: enPassantTarget, isCapture: true, isEnpassant: true, promotionPiece: nil))
                }
            }
        }
        
        return result
   }
}
