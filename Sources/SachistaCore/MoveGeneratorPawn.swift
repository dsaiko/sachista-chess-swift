//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

struct MoveGeneratorPawn: MoveGenerator {
    
    struct Cache {
        let moves          : [BitBoard]
        let doubleMoves    : [BitBoard]
        let attacks        : [BitBoard]
        
        init(color: ChessBoard.Color) {
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
        
    static let cacheWhite = Cache(color: .white)
    static let cacheBlack = Cache(color: .black)
    
    func attacks(board: ChessBoard, color: ChessBoard.Color) -> BitBoard {
        if color == .white {
            //TODO: with local variable instead of [][][].o | [][][].o ?
            return board.pieces[color][ChessBoard.Piece.pawn].oneNorthEast | board.pieces[color][ChessBoard.Piece.pawn].oneNorthWest
        } else {
            return board.pieces[color][ChessBoard.Piece.pawn].oneSouthEast | board.pieces[color][ChessBoard.Piece.pawn].oneSouthWest
        }
    }
    
    func moves(board: ChessBoard, result: inout [Move]) {
        let cache   = board.sideToMove == .white ? MoveGeneratorPawn.cacheWhite : MoveGeneratorPawn.cacheBlack
        var pieces  = board.pieces[board.sideToMove][ChessBoard.Piece.pawn]

        while pieces != .empty {
            let sourceIndex = pieces.bitPop()

            //one step forward if empty
            var moves: BitBoard = cache.moves[sourceIndex] & board.noPiecesBoard
            
            //if one step forward was successful and we are on base rank, try double move
            //TODO PERFORMANCE: bitboard or one by one move?
            if moves != .empty {
                if board.sideToMove == .white {
                    if sourceIndex <= .h2 {
                        moves |= moves.oneNorth & board.noPiecesBoard
                    }
                } else {
                    if sourceIndex >= .a7 {
                        moves |= moves.oneSouth & board.noPiecesBoard
                    }
                }
            }
            
            //add attacks
            let attacks = cache.attacks[sourceIndex]
            moves |= attacks & board.opponentPiecesBoard
            
            //transform to array of moves
            while moves != .empty {
                let targetIndex = moves.bitPop()
                
                let isPromotion = (board.sideToMove == .white && targetIndex >= .a8) || (board.sideToMove == .black && targetIndex <= .h1)

                //promotion?
                if isPromotion {
                    for piece in [ChessBoard.Piece.queen, ChessBoard.Piece.bishop, ChessBoard.Piece.knight, ChessBoard.Piece.rook] {
                        result.append(Move(piece: ChessBoard.Piece.pawn, from: sourceIndex, to: targetIndex, isEnpassant: false, promotionPiece: piece))
                    }
                } else {
                    //normal move/capture
                    result.append(Move(piece: ChessBoard.Piece.pawn, from: sourceIndex, to: targetIndex, isEnpassant: false, promotionPiece: nil))
                }
            }
            
            //check enpassant capture
            //TODO PERFORMANCE: what isEnpassange is used for?
            if let enPassantTarget = board.enPassantTarget {
                moves = attacks & enPassantTarget.bitBoard
                if moves != .empty {
                    result.append(Move(piece: ChessBoard.Piece.pawn, from: sourceIndex, to: enPassantTarget, isEnpassant: true, promotionPiece: nil))
                }
            }
        }
   }
}
