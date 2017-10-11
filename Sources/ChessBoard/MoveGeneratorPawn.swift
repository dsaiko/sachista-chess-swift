//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public class MoveGeneratorPawn: MoveGenerator {
    
    //TODO: struct?
    class Cache {

        //TODO: struct?
        class PregeneratedInfo {
            let moves:          [BitBoard]
            let doubleMoves:    [BitBoard]
            let attacks:        [BitBoard]
            
            init(color: Piece.Color) {

                var moves =         [BitBoard](repeating: .empty, count: 64)
                var doubleMoves =   [BitBoard](repeating: .empty, count: 64)
                var attacks =       [BitBoard](repeating: .empty, count: 64)
                
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
        
        static let white = PregeneratedInfo(color: .white)
        static let black = PregeneratedInfo(color: .black)
    }
    
    func attacks(board: ChessBoard, color: Piece.Color) -> BitBoard {
        //TODO PERFORMANCE: pregenerated??
        return color == .white ? (board.whitePieces.pawn.oneNorthEast | board.whitePieces.pawn.oneNorthWest) : (board.blackPieces.pawn.oneSouthEast | board.blackPieces.pawn.oneSouthWest)
    }
    
    func moves(board: ChessBoard) -> [Move] {
        let emptyBoard = board.allPieces
        
        return []
        
//        int whiteBaseRank;
//        int blackBaseRank;
//
//        int whitePromotionRank;
//        int blackPromotionRank;
//
//        if(board.nextMove == White) {
//            whiteBaseRank = 16;
//            blackBaseRank = 999;
//
//            whitePromotionRank = 55;
//            blackPromotionRank = 0;
//        } else {
//            whiteBaseRank = 0;
//            blackBaseRank = 47;
//
//            whitePromotionRank = 999;
//            blackPromotionRank = 8;
//        }
//
//        bitmask pawns = board.pieces[board.nextMove][Pawn];
//
//        //while there are pieces
//        while (pawns) {
//            //get next piece
//            const int sourceIndex = BitBoard::bitPop(pawns);
//
//            //get possible moves - moves minus my onw color
//            //one step forward
//            bitmask movesBoard = PAWN_MOVES[board.nextMove][sourceIndex] & emptyBoard;
//
//            //if one step forward was successful and we are on base rank, try double move
//            if(sourceIndex < whiteBaseRank && movesBoard) {
//                movesBoard |=  BitBoard::oneNorth(movesBoard) & emptyBoard;
//            } else if(sourceIndex > blackBaseRank && movesBoard) {
//                movesBoard |=  BitBoard::oneSouth(movesBoard) & emptyBoard;
//            }
//
//            //get attacks, only against opponent pieces
//            const bitmask attacks = PAWN_ATTACKS[board.nextMove][sourceIndex];
//            movesBoard |=  attacks & stats.opponentPieces;
//
//            //for all moves
//            while (movesBoard) {
//                //get next move
//                const int targetIndex = BitBoard::bitPop(movesBoard);
//                bool isCapture = (BitBoard::squareBitmask(targetIndex) & stats.opponentPieces) != 0;
//
//                //promotion?
//                if (targetIndex > whitePromotionRank || targetIndex < blackPromotionRank) {
//                    moves.setNext(Pawn, sourceIndex, targetIndex, isCapture, false, Bishop);
//                    moves.setNext(Pawn, sourceIndex, targetIndex, isCapture, false, Knight);
//                    moves.setNext(Pawn, sourceIndex, targetIndex, isCapture, false, Queen);
//                    moves.setNext(Pawn, sourceIndex, targetIndex, isCapture, false, Rook);
//                } else {
//                    //normal move/capture
//                    moves.setNext(Pawn, sourceIndex, targetIndex, isCapture);
//                }
//            }
//
//            //check enpassant capture
//            if(board.enPassantTargetIndex) {
//                movesBoard = attacks & BitBoard::squareBitmask(board.enPassantTargetIndex);
//                if (movesBoard) {
//                    moves.setNext(Pawn, sourceIndex, BitBoard::bitScan(movesBoard), true, true, NoPiece);
//                }
//            }
//
//        }
    }
    
}
