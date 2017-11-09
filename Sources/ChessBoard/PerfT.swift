//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

extension ChessBoard {

    //optimized check for king check
    //TODO try replace by isBitMaskUnderAttack
    //TODO what should be fce and what property? general.
    func isOpponentsKingUnderCheck() -> Bool {

        let opponentKing = (nextMove == .white ? blackPieces : whitePieces).king
        if opponentKing == 0 { return false }

        //this could be
        //return (attacks(color: nextMove) & opponentKing) == 0
        //but following performs better

        let opponentKingIndex = opponentKing.trailingZeroBitCount

        //TODO: rawValue or Int??
        //TODO: simplify!
        let opponentPawnCache = nextMove == .white ? MoveGeneratorPawn.cacheBlack : MoveGeneratorPawn.cacheWhite
        if (piecesToMove.pawn & opponentPawnCache.attacks[opponentKingIndex]) != 0 {
            return true
        }
        if (piecesToMove.knight & MoveGeneratorKnight.cache.moves[opponentKingIndex]) != 0 {
            return true
        }

        if (piecesToMove.king & MoveGeneratorKing.cache.moves[opponentKingIndex]) != 0 {
            return true
        }

        let rooks = piecesToMove.rook | piecesToMove.queen
        if (MoveGeneratorRook.cache.rankMoves[opponentKingIndex][Int((allPieces & MoveGeneratorRook.cache.rankMask[opponentKingIndex]) >> MoveGeneratorRook.cache.rankShift[opponentKingIndex])] & rooks) != 0 {
            return true
        }
        if (MoveGeneratorRook.cache.fileMoves[opponentKingIndex][Int(((allPieces & MoveGeneratorRook.cache.fileMask[opponentKingIndex]) &* MoveGeneratorRook.cache.fileMagic[opponentKingIndex]) >> 57)] & rooks) != 0 {
            return true
        }

        //TODO: is this already used at moveGenBishop, make lazy var
        let bishops = piecesToMove.bishop | piecesToMove.queen

        if (MoveGeneratorBishop.cache.a8H1Moves[opponentKingIndex][Int(((allPieces & MoveGeneratorBishop.cache.a8H1Mask[opponentKingIndex]) &* MoveGeneratorBishop.cache.a8H1Magic[opponentKingIndex]) >> 57)] & bishops) != 0 {
            return true
        }

        if (MoveGeneratorBishop.cache.a1H8Moves[opponentKingIndex][Int(((allPieces & MoveGeneratorBishop.cache.a1H8Mask[opponentKingIndex]) &* MoveGeneratorBishop.cache.a1H8Magic[opponentKingIndex]) >> 57)] & bishops) != 0 {
            return true
        }

        return false
    }

    
    //TODO: implement threading
    func perft(depth: Int) -> UInt64 {

        if(depth < 1) { return 1 }

        var count: UInt64 = 0

        let attacks = self.attacks(color: opponentColor)
        let isCheck = (attacks & self.kingBoard) != 0

        for move in pseudoLegalMoves() {
            let sourceBitBoard = move.from.bitBoard
            let isKingMove = move.piece == . whiteKing || move.piece == .blackKing

            if depth == 1 {
               if isKingMove || isCheck || ((sourceBitBoard & attacks) != 0) || move.isEnpassant {
                    //for depth == 1 we need to make move only in this case
                    let nextBoard = makeMove(move: move)
                    if !nextBoard.isOpponentsKingUnderCheck() {
                        count += 1
                    }
               } else {
                   count += 1
               }
            } else {
                let nextBoard = makeMove(move: move)
                if isKingMove || isCheck || ((sourceBitBoard & attacks) != 0) || move.isEnpassant {
                    //for depth == 1 we need to make move only in this case
                    if !nextBoard.isOpponentsKingUnderCheck() {
                        count += nextBoard.perft(depth: depth - 1)
                    }
               } else {
                   count += nextBoard.perft(depth: depth - 1)
               }
            }
        }
        return count
    }
}





