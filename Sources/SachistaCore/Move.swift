//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

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
    
    func moves(board: ChessBoard, result: inout [Move])
}

extension ChessBoard {
    
    private static let MOVES_ARRAY_INITIAL_CAPACITY = 32
    
    func pseudoLegalMoves() -> [Move]
    {
        //moves without validation of attack to king
        var moves = [Move]()
        moves.reserveCapacity(ChessBoard.MOVES_ARRAY_INITIAL_CAPACITY)
        
        for moveGenerator in ChessBoard.moveGenerators {
            moveGenerator.moves(board: self, result: &moves)
        }
        
        return moves
    }
    
    func attacks(color: Color) -> BitBoard
    {
        var result: BitBoard = .empty
        
        for moveGenerator in ChessBoard.moveGenerators {
            result |= moveGenerator.attacks(board: self, color: color)
        }
        return result
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

        var halfMoveClock   = self.halfMoveClock &+ 1
        var enPassantTarget: BitBoard.Index? = nil
        var fullMoveNumber  = self.fullMoveNumber
        var sideToMove      = self.sideToMove
        var pieces          = self.pieces
        var castlingOptions = self.castlingOptions
        
        func modifyPiece(color: Color, piece: Piece, f:(inout BitBoard) -> Void) {
            if color == .white {
                switch piece {
                case .king:     f(&pieces.white.king)
                case .queen:    f(&pieces.white.queen)
                case .rook:     f(&pieces.white.rook)
                case .knight:   f(&pieces.white.knight)
                case .bishop:   f(&pieces.white.bishop)
                case .pawn:     f(&pieces.white.pawn)
                }
            } else {
                switch piece {
                case .king:     f(&pieces.black.king)
                case .queen:    f(&pieces.black.queen)
                case .rook:     f(&pieces.black.rook)
                case .knight:   f(&pieces.black.knight)
                case .bishop:   f(&pieces.black.bishop)
                case .pawn:     f(&pieces.black.pawn)
                }
            }
            
        }
        
        modifyPiece(color: sideToMove, piece: move.piece) { $0 ^= sourceBitBoard | targetBitBoard }

        if move.piece == .rook {
            if sideToMove == .white {
                if sourceIndex == .a1 {
                    castlingOptions.white.queenside = false
                } else if sourceIndex == .h1 {
                    castlingOptions.white.kingside = false
                }
            } else {
                if sourceIndex == .a8 {
                    castlingOptions.black.queenside = false
                } else if sourceIndex == .h8 {
                    castlingOptions.black.kingside = false
                }
            }
        } else if move.piece == .king {
            if sideToMove == .white {
                castlingOptions.white = (false, false)
            } else {
                castlingOptions.black = (false, false)
            }

            if sideToMove == .white {
                if sourceIndex == .e1 {
                    //handle castling
                    if targetIndex == .c1 {
                        pieces.white.rook ^= BitBoard.a1 | BitBoard.d1
                    } else if targetIndex == .g1 {
                        pieces.white.rook ^= BitBoard.h1 | BitBoard.f1
                    }
                }
            } else {
                if sourceIndex == .e8 {
                    //handle castling
                    if targetIndex == .c8 {
                        pieces.black.rook ^= BitBoard.a8 | BitBoard.d8
                    } else if targetIndex == .g8 {
                        pieces.black.rook ^= BitBoard.h8 | BitBoard.f8
                    }
                }
            }
        } else if move.piece == .pawn {
            halfMoveClock = 0

            //initial pawn double move
            if abs(targetIndex.rawValue &- sourceIndex.rawValue) > 10 {
                enPassantTarget = BitBoard.Index(rawValue: sourceIndex.rawValue &+ (sideToMove == .white ? 8 : -8))!
            } else if let promotionPiece = move.promotionPiece {
                modifyPiece(color: sideToMove, piece: Piece.pawn) { $0 ^= targetBitBoard }
                modifyPiece(color: sideToMove, piece: promotionPiece) { $0 |= targetBitBoard }
            }
        }

        let isCapture = (targetBitBoard & opponentPiecesBoard) != 0
        if isCapture || move.isEnpassant {
            halfMoveClock = 0
            
            if move.isEnpassant {
                //remove captured piece
                if sideToMove == .white {
                    pieces.black.pawn ^= targetBitBoard.oneSouth
                } else {
                    pieces.white.pawn ^= targetBitBoard.oneNorth
                }
            } else {
                var found = false
                for piece in Piece.values {
                    modifyPiece(color: opponentColor, piece: piece) {
                        bitboard in
                        
                        if (bitboard & targetBitBoard) != 0 {
                            bitboard ^= targetBitBoard
                            
                            if piece == .rook {
                                if sideToMove == .white {
                                    if targetIndex == .a8 {
                                        castlingOptions.black.queenside = false
                                    } else if targetIndex == .h8 {
                                        castlingOptions.black.kingside = false
                                    }
                                } else {
                                    if targetIndex == .a1 {
                                        castlingOptions.white.queenside = false
                                    } else if targetIndex == .h1 {
                                        castlingOptions.white.kingside = false
                                    }
                                }
                            }
                            found = true
                        }
                    }
                    if found {
                        break
                    }
                }
            }
        }

        if sideToMove == .black {
            fullMoveNumber = fullMoveNumber &+ 1
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
        
        let opponentKing = piecesBy(color: opponentColor).king
        if opponentKing == .empty { return false } //TODO: 0 vs .empty
        
        //debug check: only 1 king allowed
        assert(opponentKing.nonzeroBitCount == 1, "There can be only one king on the board.")

        //TODO: retest one liner performance
        //this function could be one liner:
        //return (attacks(color: sideToMove) & opponentKing) != 0
        //but following performs better
        
        let opponentKingIndex = opponentKing.trailingZeroBitCount
        let myPieces = piecesBy(color: sideToMove)
        
        //TODO: rawValue or Int??
        //TODO: simplify!
        let opponentPawnCache = sideToMove == .white ? MoveGeneratorPawn.cacheBlack : MoveGeneratorPawn.cacheWhite
        if (myPieces.pawn & opponentPawnCache.attacks[opponentKingIndex]) != 0 {
            return true
        }
        if (myPieces.knight & MoveGeneratorKnight.cache.moves[opponentKingIndex]) != 0 {
            return true
        }

        if (myPieces.king & MoveGeneratorKing.cache.moves[opponentKingIndex]) != 0 {
            return true
        }

        let rooks = myPieces.rook | myPieces.queen
        if (MoveGeneratorRook.cache.rankMoves[opponentKingIndex][Int((allPiecesBoard & MoveGeneratorRook.cache.rankMask[opponentKingIndex]) &>> MoveGeneratorRook.cache.rankShift[opponentKingIndex])] & rooks) != 0 {
            return true
        }
        if (MoveGeneratorRook.cache.fileMoves[opponentKingIndex][Int(((allPiecesBoard & MoveGeneratorRook.cache.fileMask[opponentKingIndex]) &* MoveGeneratorRook.cache.fileMagic[opponentKingIndex]) &>> 57)] & rooks) != 0 {
            return true
        }

        //TODO: is this already used at moveGenBishop, make lazy var?
        let bishops = myPieces.bishop | myPieces.queen

        if (MoveGeneratorBishop.cache.a8H1Moves[opponentKingIndex][Int(((allPiecesBoard & MoveGeneratorBishop.cache.a8H1Mask[opponentKingIndex]) &* MoveGeneratorBishop.cache.a8H1Magic[opponentKingIndex]) &>> 57)] & bishops) != 0 {
            return true
        }

        if (MoveGeneratorBishop.cache.a1H8Moves[opponentKingIndex][Int(((allPiecesBoard & MoveGeneratorBishop.cache.a1H8Mask[opponentKingIndex]) &* MoveGeneratorBishop.cache.a1H8Magic[opponentKingIndex]) &>> 57)] & bishops) != 0 {
            return true
        }

        return false
    }

}

