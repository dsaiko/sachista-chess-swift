//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

//TODO PERFORMANCE: try class?
public struct Move: CustomStringConvertible {
    let piece:          ChessBoard.Piece
    let from:           BitBoard.Index
    let to:             BitBoard.Index
    
    let isEnpassant:    Bool
    let promotionPiece: ChessBoard.Piece?

    public init(piece: ChessBoard.Piece, from: BitBoard.Index, to: BitBoard.Index, isEnpassant: Bool = false, promotionPiece: ChessBoard.Piece? = nil) {
        self.piece          = piece
        self.from           = from
        self.to             = to
        self.isEnpassant    = isEnpassant
        self.promotionPiece = promotionPiece
    }
    
    public var description: String {
        return "\(from)\(to)\((promotionPiece?.description(color: ChessBoard.Color.black) ?? ""))"
    }
}

protocol MoveGenerator {
    
    func attacks(board: ChessBoard, color: ChessBoard.Color) -> BitBoard
    
    //TODO PERFORMANCE: Move array??
    func moves(board: ChessBoard) -> [Move]
}

extension ChessBoard {
    
    func pseudoLegalMoves() -> [Move]
    {
        //moves without validation of attack to king
        return ChessBoard.moveGenerators.flatMap({ $0.moves(board: self) })
    }
    
    func attacks(color: Color) -> BitBoard
    {
        return ChessBoard.moveGenerators.flatMap({ $0.attacks(board: self, color: color) }).reduce(BitBoard(0), { $0 | $1 })
    }
    
    //TODO PERFORMANCE: try mutable chessboard
    //TODO PERFORMANCE: undo move
    //TODO PERFORMANCE: try re compute zobrist every time
    //TODO PERFORMANCE: reseting castling options in place?
    func makeMove(move: Move) -> ChessBoard {

        let sourceIndex = move.from
        let targetIndex = move.to
        let sourceBitBoard = sourceIndex.bitBoard
        let targetBitBoard = targetIndex.bitBoard

        var halfMoveClock   = self.halfMoveClock + 1
        var enPassantTarget: BitBoard.Index? = nil
        var fullMoveNumber  = self.fullMoveNumber
        var sideToMove      = self.sideToMove
        var pieces          = self.pieces
        var castlingOptions = self.castlingOptions
        
        pieces[sideToMove][move.piece] ^= sourceBitBoard | targetBitBoard

        if move.piece == .rook {
            if sideToMove == .white {
                if sourceIndex == .a1 {
                    castlingOptions[Color.white][Piece.queen] = false
                } else if sourceIndex == .h1 {
                    castlingOptions[Color.white][Piece.king] = false
                }
            } else {
                if sourceIndex == .a8 {
                    castlingOptions[Color.black][Piece.queen] = false
                } else if sourceIndex == .h8 {
                    castlingOptions[Color.black][Piece.king] = false
                }
            }
        } else if move.piece == .king {
            castlingOptions[sideToMove] = [false, false]

            if sideToMove == .white {
                if sourceIndex == .e1 {
                    //handle castling
                    if targetIndex == .c1 {
                        pieces[sideToMove][Piece.rook] ^= BitBoard.a1 | BitBoard.d1
                    } else if targetIndex == .g1 {
                        pieces[sideToMove][Piece.rook] ^= BitBoard.h1 | BitBoard.f1
                    }
                }
            } else {
                if sourceIndex == .e8 {
                    //handle castling
                    if targetIndex == .c8 {
                        pieces[sideToMove][Piece.rook] ^= BitBoard.a8 | BitBoard.d8
                    } else if targetIndex == .g8 {
                        pieces[sideToMove][Piece.rook] ^= BitBoard.h8 | BitBoard.f8
                    }
                }
            }
        } else if move.piece == .pawn {
            halfMoveClock = 0

            //initial pawn double move
            if abs(targetIndex.rawValue - sourceIndex.rawValue) > 10 {
                enPassantTarget = BitBoard.Index(rawValue: sourceIndex.rawValue + (sideToMove == .white ? 8 : -8))!
            } else if let promotionPiece = move.promotionPiece {
                pieces[sideToMove][Piece.pawn] ^= targetBitBoard

                pieces[sideToMove][promotionPiece] |= targetBitBoard
            }
        }

        let isCapture = (targetBitBoard & opponentPiecesBoard) != 0
        if isCapture || move.isEnpassant {
            halfMoveClock = 0
            
            if move.isEnpassant {
                //remove captured piece
                if sideToMove == .white {
                    pieces[opponentColor][Piece.pawn] ^= targetBitBoard.oneSouth
                } else {
                    pieces[opponentColor][Piece.pawn] ^= targetBitBoard.oneNorth
                }
            } else {
                for piece in Piece.values {
                    let bitboard = pieces[opponentColor][piece]
                    
                    //TODO: change to immadiate XOR and compare result
                    //TODO: change order of comparisons, what about isEnpassant?
                    if (bitboard & targetBitBoard) != 0 {
                        pieces[opponentColor][piece] ^= targetBitBoard
                        
                        if piece == .rook {
                            if sideToMove == .white {
                                if targetIndex == .a8 {
                                    castlingOptions[opponentColor][Piece.queen] = false
                                } else if targetIndex == .h8 {
                                    castlingOptions[opponentColor][Piece.king] = false
                                }
                            } else {
                                if targetIndex == .a1 {
                                    castlingOptions[opponentColor][Piece.queen] = false
                                } else if targetIndex == .h1 {
                                    castlingOptions[opponentColor][Piece.king] = false
                                }
                            }
                        }
                        break
                    }
                }
            }
        }

        if sideToMove == .black {
            fullMoveNumber += 1
        }

        sideToMove = self.opponentColor
        
        let newBoard = ChessBoard(
            sideToMove:             sideToMove,
            pieces:                 pieces,
            castlingOptions:        castlingOptions,
            enPassantTarget:        enPassantTarget,
            halfMoveClock:          halfMoveClock,
            fullMoveNumber:         fullMoveNumber
        )
        
        return newBoard
    }
}

extension ChessBoard {
    
    //optimized check for king check
    //TODO try replace by isBitMaskUnderAttack
    //TODO what should be fce and what property? general.
    func isOpponentsKingUnderCheck() -> Bool {
        
        let opponentKing = pieces[opponentColor][Piece.king]
        if opponentKing == .empty { return false } //TODO: 0 vs .empty
        
        //debug check: only 1 king allowed
        assert(opponentKing.nonzeroBitCount == 1, "There can be only one king on the board.")

        //TODO: retest one liner performance
        //this function could be one liner:
        //return (attacks(color: sideToMove) & opponentKing) != 0
        //but following performs better
        
        let opponentKingIndex = opponentKing.trailingZeroBitCount

        //TODO: rawValue or Int??
        //TODO: simplify!
        let opponentPawnCache = sideToMove == .white ? MoveGeneratorPawn.cacheBlack : MoveGeneratorPawn.cacheWhite
        if (pieces[sideToMove][Piece.pawn] & opponentPawnCache.attacks[opponentKingIndex]) != 0 {
            return true
        }
        if (pieces[sideToMove][Piece.knight] & MoveGeneratorKnight.cache.moves[opponentKingIndex]) != 0 {
            return true
        }

        if (pieces[sideToMove][Piece.king] & MoveGeneratorKing.cache.moves[opponentKingIndex]) != 0 {
            return true
        }

        let rooks = pieces[sideToMove][Piece.rook] | pieces[sideToMove][Piece.queen]
        if (MoveGeneratorRook.cache.rankMoves[opponentKingIndex][Int((allPiecesBoard & MoveGeneratorRook.cache.rankMask[opponentKingIndex]) >> MoveGeneratorRook.cache.rankShift[opponentKingIndex])] & rooks) != 0 {
            return true
        }
        if (MoveGeneratorRook.cache.fileMoves[opponentKingIndex][Int(((allPiecesBoard & MoveGeneratorRook.cache.fileMask[opponentKingIndex]) &* MoveGeneratorRook.cache.fileMagic[opponentKingIndex]) >> 57)] & rooks) != 0 {
            return true
        }

        //TODO: is this already used at moveGenBishop, make lazy var?
        let bishops = pieces[sideToMove][Piece.bishop] | pieces[sideToMove][Piece.queen]

        if (MoveGeneratorBishop.cache.a8H1Moves[opponentKingIndex][Int(((allPiecesBoard & MoveGeneratorBishop.cache.a8H1Mask[opponentKingIndex]) &* MoveGeneratorBishop.cache.a8H1Magic[opponentKingIndex]) >> 57)] & bishops) != 0 {
            return true
        }

        if (MoveGeneratorBishop.cache.a1H8Moves[opponentKingIndex][Int(((allPiecesBoard & MoveGeneratorBishop.cache.a1H8Mask[opponentKingIndex]) &* MoveGeneratorBishop.cache.a1H8Magic[opponentKingIndex]) >> 57)] & bishops) != 0 {
            return true
        }

        return false
    }

}

