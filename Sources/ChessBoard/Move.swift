//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

//TODO PERFORMANCE: try class?
public struct Move: CustomStringConvertible {
    let piece:          Piece
    
    let from:           BitBoard.Index
    let to:             BitBoard.Index
    
    let isCapture:      Bool
    let isEnpassant:    Bool
    let promotionPiece: Piece?

    public init(piece: Piece, from: BitBoard.Index, to: BitBoard.Index, isCapture: Bool = false, isEnpassant: Bool = false, promotionPiece: Piece? = nil) {
        self.piece          = piece
        self.from           = from
        self.to             = to
        self.isCapture      = isCapture
        self.isEnpassant    = isEnpassant
        self.promotionPiece = promotionPiece
    }
    
    public var description: String {
        return "\(from)\(isCapture ? "x" : "")\(to)\((promotionPiece?.description ?? "").lowercased())"
    }
}

protocol MoveGenerator {
    
    func attacks(board: ChessBoard, color: Piece.Color) -> BitBoard
    
    //TODO PERFORMANCE: Move array??
    func moves(board: ChessBoard) -> [Move]
}

extension ChessBoard {
    
    func pseudoLegalMoves() -> [Move]
    {
        //moves without validation of attack to king
        return ChessBoard.moveGenerators.flatMap({ $0.moves(board: self) })
    }
    
    func attacks(color: Piece.Color) -> BitBoard
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

        var halfMoveClock = self.halfMoveClock + 1
        var zobristChecksum = self.zobristChecksum
        var enPassantTarget = self.enPassantTarget

        var isWhiteKingSideCastlingAvailable    = self.whiteCastlingOptions.isKingSideCastlingAvailable
        var isWhiteQueenSideCastlingAvailable   = self.whiteCastlingOptions.isQueenSideCastlingAvailable
        var isBlackKingSideCastlingAvailable    = self.blackCastlingOptions.isKingSideCastlingAvailable
        var isBlackQueenSideCastlingAvailable   = self.blackCastlingOptions.isQueenSideCastlingAvailable
        
        var fullMoveNumber                      = self.fullMoveNumber
        var nextMove                            = self.nextMove
        
        var whiteKing                           = self.whitePieces.king
        var whiteQueen                          = self.whitePieces.queen
        var whiteBishop                         = self.whitePieces.bishop
        var whiteKnight                         = self.whitePieces.knight
        var whiteRook                           = self.whitePieces.rook
        var whitePawn                           = self.whitePieces.pawn

        var blackKing                           = self.blackPieces.king
        var blackQueen                          = self.blackPieces.queen
        var blackBishop                         = self.blackPieces.bishop
        var blackKnight                         = self.blackPieces.knight
        var blackRook                           = self.blackPieces.rook
        var blackPawn                           = self.blackPieces.pawn

        //reset enPassant
        if let target = enPassantTarget {
            zobristChecksum ^= ZobristChecksum.rndEnPassantFile[target.fileIndex]
            enPassantTarget = nil
        }

        //remove castling options, will set them at the end
        //TODO: move inline? + castling
        if isWhiteKingSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingWhiteKing
        }
        if isWhiteQueenSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingWhiteQueen
        }
        if isBlackKingSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingBlackKing
        }
        if isBlackQueenSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingBlackQueen
        }
        
        //TODO PERFORMANCE: try to use the pieces map
        switch move.piece {
            case .whiteKing:     whiteKing          ^= sourceBitBoard | targetBitBoard
            case .whiteQueen:    whiteQueen         ^= sourceBitBoard | targetBitBoard
            case .whiteBishop:   whiteBishop        ^= sourceBitBoard | targetBitBoard
            case .whiteKnight:   whiteKnight        ^= sourceBitBoard | targetBitBoard
            case .whiteRook:     whiteRook          ^= sourceBitBoard | targetBitBoard
            case .whitePawn:     whitePawn          ^= sourceBitBoard | targetBitBoard
            
            case .blackKing:     blackKing          ^= sourceBitBoard | targetBitBoard
            case .blackQueen:    blackQueen         ^= sourceBitBoard | targetBitBoard
            case .blackBishop:   blackBishop        ^= sourceBitBoard | targetBitBoard
            case .blackKnight:   blackKnight        ^= sourceBitBoard | targetBitBoard
            case .blackRook:     blackRook          ^= sourceBitBoard | targetBitBoard
            case .blackPawn:     blackPawn          ^= sourceBitBoard | targetBitBoard
        }
        
        zobristChecksum ^= ZobristChecksum.rndPieces[move.piece.rawValue][sourceIndex.rawValue] ^ ZobristChecksum.rndPieces[move.piece.rawValue][targetIndex.rawValue]

        if move.piece == .whiteRook {
            if sourceIndex == .a1 {
                isWhiteQueenSideCastlingAvailable = false
            } else if sourceIndex == .h1 {
                isWhiteKingSideCastlingAvailable = false
            }
        } else if move.piece == .blackRook {
            if sourceIndex == .a8 {
                isBlackQueenSideCastlingAvailable = false
            } else if sourceIndex == .h8 {
                isBlackKingSideCastlingAvailable = false
            }
        } else if move.piece == .whiteKing {
            isWhiteQueenSideCastlingAvailable = false
            isWhiteKingSideCastlingAvailable = false
            
            if sourceIndex == .e1 {
                //handle castling
                if targetIndex == .c1 {
                    whiteRook ^= BitBoard.a1 | BitBoard.d1
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteRook.rawValue][BitBoard.Index.a1.rawValue] ^ ZobristChecksum.rndPieces[Piece.whiteRook.rawValue][BitBoard.Index.d1.rawValue]
                } else if targetIndex == .g1 {
                    whiteRook ^= BitBoard.h1 | BitBoard.f1
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteRook.rawValue][BitBoard.Index.h1.rawValue] ^ ZobristChecksum.rndPieces[Piece.whiteRook.rawValue][BitBoard.Index.f1.rawValue]
                }
            }
        } else if move.piece == .blackKing {
            isBlackQueenSideCastlingAvailable = false
            isBlackKingSideCastlingAvailable = false
            
            if sourceIndex == .e8 {
                //handle castling
                if targetIndex == .c8 {
                    blackRook ^= BitBoard.a8 | BitBoard.d8
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackRook.rawValue][BitBoard.Index.a8.rawValue] ^ ZobristChecksum.rndPieces[Piece.blackRook.rawValue][BitBoard.Index.d8.rawValue]
                } else if targetIndex == .g8 {
                    blackRook ^= BitBoard.h8 | BitBoard.f8
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackRook.rawValue][BitBoard.Index.h8.rawValue] ^ ZobristChecksum.rndPieces[Piece.blackRook.rawValue][BitBoard.Index.f8.rawValue]
                }
            }
        } else if move.piece == .whitePawn {
            halfMoveClock = 0

            //initial pawn double move
            if abs(targetIndex.rawValue - sourceIndex.rawValue) > 10 {
                enPassantTarget = BitBoard.Index(rawValue: sourceIndex.rawValue + 8)!
            } else if let promotionPiece = move.promotionPiece {
                whitePawn ^= targetBitBoard
                zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whitePawn.rawValue][targetIndex.rawValue]
                
                //TODO: SIMPLIFY!
                if promotionPiece == .whiteQueen {
                    whiteQueen |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteQueen.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .whiteBishop {
                    whiteBishop |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteBishop.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .whiteKnight {
                    whiteKnight |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteKnight.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .whiteRook {
                    whiteRook |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteRook.rawValue][targetIndex.rawValue]
                }
            }
        } else if move.piece == .blackPawn {
            halfMoveClock = 0
            
            //initial pawn double move
            if abs(targetIndex.rawValue - sourceIndex.rawValue) > 10 {
                enPassantTarget = BitBoard.Index(rawValue: sourceIndex.rawValue + -8)!
            } else if let promotionPiece = move.promotionPiece {
                blackPawn ^= targetBitBoard
                zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackPawn.rawValue][targetIndex.rawValue]
                
                //TODO: SIMPLIFY!
                if promotionPiece == .blackQueen {
                    blackQueen |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackQueen.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .blackBishop {
                    blackBishop |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackBishop.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .blackKnight {
                    blackKnight |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackKnight.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .blackRook {
                    blackRook |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackRook.rawValue][targetIndex.rawValue]
                }
            }
        }

        if move.isCapture {
            halfMoveClock = 0
            
            
            if move.isEnpassant {
                //remove captured piece
                if move.piece == .whitePawn {
                    blackPawn ^= targetBitBoard.oneSouth
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackPawn.rawValue][targetIndex.rawValue - 8]
                } else {
                    whitePawn ^= targetBitBoard.oneNorth
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whitePawn.rawValue][targetIndex.rawValue + 8]
                }
            } else if nextMove == .white {
                //TODO: change to immadiate XOR and compare result
                //TODO: simplify for both colors
                //TODO: change order of comparisons, what about isEnpassant?
                if (blackPawn & targetBitBoard) != 0 {
                    blackPawn ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackPawn.rawValue][targetIndex.rawValue]
                } else if (blackBishop & targetBitBoard) != 0 {
                    blackBishop ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackBishop.rawValue][targetIndex.rawValue]
                } else if (blackKnight & targetBitBoard) != 0 {
                    blackKnight ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackKnight.rawValue][targetIndex.rawValue]
                } else if (blackQueen & targetBitBoard) != 0 {
                    blackQueen ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackQueen.rawValue][targetIndex.rawValue]
                } else if (blackRook & targetBitBoard) != 0 {
                    blackRook ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackRook.rawValue][targetIndex.rawValue]
                    
                    if targetIndex == .a8 {
                        isBlackQueenSideCastlingAvailable = false
                    } else if targetIndex == .h8 {
                        isBlackKingSideCastlingAvailable = false
                    }
                }
                
            } else {
                if (whitePawn & targetBitBoard) != 0 {
                    whitePawn ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whitePawn.rawValue][targetIndex.rawValue]
                } else if (whiteBishop & targetBitBoard) != 0 {
                    whiteBishop ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteBishop.rawValue][targetIndex.rawValue]
                } else if (whiteKnight & targetBitBoard) != 0 {
                    whiteKnight ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteKnight.rawValue][targetIndex.rawValue]
                } else if (whiteQueen & targetBitBoard) != 0 {
                    whiteQueen ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteQueen.rawValue][targetIndex.rawValue]
                } else if (whiteRook & targetBitBoard) != 0 {
                    whiteRook ^= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteRook.rawValue][targetIndex.rawValue]
                    
                    if targetIndex == .a1 {
                        isWhiteQueenSideCastlingAvailable = false
                    } else if targetIndex == .h1 {
                        isWhiteKingSideCastlingAvailable = false
                    }
                }
            }
        }

        if nextMove == .black {
            fullMoveNumber += 1
        }

        nextMove = self.opponentColor
        zobristChecksum ^= ZobristChecksum.rndBlackSide //switch the side
        
        //set enPassant
        if let target = enPassantTarget {
            zobristChecksum ^= ZobristChecksum.rndEnPassantFile[target.fileIndex]
        }
        
        //set castling options
        if isWhiteKingSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingWhiteKing
        }
        if isWhiteQueenSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingWhiteQueen
        }
        if isBlackKingSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingBlackKing
        }
        if isBlackQueenSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingBlackQueen
        }
        
        let whitePieces = Pieces(
            king:   whiteKing,
            queen:  whiteQueen,
            bishop: whiteBishop,
            knight: whiteKnight,
            rook:   whiteRook,
            pawn:   whitePawn
        )
        
        let blackPieces = Pieces(
            king:   blackKing,
            queen:  blackQueen,
            bishop: blackBishop,
            knight: blackKnight,
            rook:   blackRook,
            pawn:   blackPawn
        )
        
        let newBoard = ChessBoard(
            nextMove:               nextMove,
            whitePieces:            whitePieces,
            blackPieces:            blackPieces,
            whiteCastlingOptions:   CastlingOptions(isKingSideCastlingAvailable: isWhiteKingSideCastlingAvailable, isQueenSideCastlingAvailable: isWhiteQueenSideCastlingAvailable),
            blackCastlingOptions:   CastlingOptions(isKingSideCastlingAvailable: isBlackKingSideCastlingAvailable, isQueenSideCastlingAvailable: isBlackQueenSideCastlingAvailable),
            enPassantTarget:        enPassantTarget,
            halfMoveClock:          halfMoveClock,
            fullMoveNumber:         fullMoveNumber,
            zobristChecksum:        zobristChecksum
        )
        
        assert(zobristChecksum == ZobristChecksum.compute(board: newBoard))

        return newBoard
    }
}

