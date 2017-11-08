//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

extension ChessBoard {

    //optimized check for king check
    //TODO try replace by isBitMaskUnderAttack
    //TODO what should be fce and what property? general.
    func isOpponentsKingNotUnderCheck() -> Bool {

        let opponentKing = (nextMove == .white ? blackPieces : whitePieces).king
        return (attacks(color: nextMove) & opponentKing) == 0

//        if opponentKing == 0 { return false }
//        let opponentKingIndex = BitBoard.Index(rawValue: opponentKing.trailingZeroBitCount)!
//
//        //TODO: rawValue or Int??
//        //TODO: simplify!
//        let opponentPawnCache = nextMove == .white ? MoveGeneratorPawn.cacheBlack : MoveGeneratorPawn.cacheWhite
//        if (piecesToMove.pawn & opponentPawnCache.attacks[opponentKingIndex.rawValue]) != 0 {
//            return false
//        }
//        if (piecesToMove.knight & MoveGeneratorKnight.cache.moves[opponentKingIndex.rawValue]) != 0 {
//            return false
//        }
//
//        if (piecesToMove.king & MoveGeneratorKing.cache.moves[opponentKingIndex.rawValue]) != 0 {
//            return false
//        }
//
//        let rooks = piecesToMove.rook | piecesToMove.queen
//        if (MoveGeneratorRook.cache.rankMoves[opponentKingIndex.rawValue][Int((allPieces & MoveGeneratorRook.cache.rankMask[opponentKingIndex.rawValue]) >> MoveGeneratorRook.cache.rankShift[opponentKingIndex.rawValue])] & rooks) != 0 {
//            return false
//        }
//        if (MoveGeneratorRook.cache.fileMoves[opponentKingIndex.rawValue][Int(((allPieces & MoveGeneratorRook.cache.fileMask[opponentKingIndex.rawValue]) &* MoveGeneratorRook.cache.fileMagic[opponentKingIndex.rawValue] >> MoveGeneratorRook.cache.rankShift[opponentKingIndex.rawValue]) >> 57)] & rooks) != 0 {
//            return false
//        }
//
//        //TODO: is this already used at moveGenBishop, make lazy var
//        let bishops = piecesToMove.bishop | piecesToMove.queen
//
//        if (MoveGeneratorBishop.cache.a8H1Moves[opponentKingIndex.rawValue][Int(((allPieces & MoveGeneratorBishop.cache.a8H1Mask[opponentKingIndex.rawValue]) &* MoveGeneratorBishop.cache.a8H1Magic[opponentKingIndex.rawValue]) >> 57)] & bishops) != 0 {
//            return false
//        }
//
//        if (MoveGeneratorBishop.cache.a1H8Moves[opponentKingIndex.rawValue][Int(((allPieces & MoveGeneratorBishop.cache.a1H8Mask[opponentKingIndex.rawValue]) &* MoveGeneratorBishop.cache.a1H8Magic[opponentKingIndex.rawValue]) >> 57)] & bishops) != 0 {
//            return false
//        }
//
//        return true
    }

    //TODO: implement cache
    //TODO: implement threading
    func perft(depth: Int) -> UInt64 {

        if(depth < 1) { return 1 }

        var count: UInt64 = 0

        for move in pseudoLegalMoves() {
            let nextBoard = makeMove(move: move)

            if nextBoard.isOpponentsKingNotUnderCheck() {
                count += nextBoard.perft(depth: depth - 1)
            }
        }

//        let attacks = self.attacks(color: opponentColor)
//        let isCheck = (attacks & self.kingBoard) != 0
//
//        for move in pseudoLegalMoves() {
//            let sourceBitBoard = move.from.bitBoard
//
//            if depth == 1 {
//                if ((sourceBitBoard & kingBoard) != 0) || isCheck || ((sourceBitBoard & attacks) != 0) || move.isEnpassant {
//                    //for depth == 1 we need to make move only in this case
//                    let nextBoard = makeMove(move: move)
//                    if nextBoard.isOpponentsKingNotUnderCheck() {
//                        count += 1
//                    }
//                } else {
//                    count += 1
//                }
//            } else {
//                let nextBoard = makeMove(move: move)
//                if ((sourceBitBoard & kingBoard) != 0) || isCheck || ((sourceBitBoard & attacks) != 0) || move.isEnpassant {
//                    //for depth == 1 we need to make move only in this case
//                    if nextBoard.isOpponentsKingNotUnderCheck() {
//                        count += perft(depth: depth - 1)
//                    }
//                } else {
//                    count += perft(depth: depth - 1)
//                }
//            }
//
//        }
        return count
    }
}





