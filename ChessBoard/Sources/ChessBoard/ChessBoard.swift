//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public enum PieceColor {
    case white
    case black
}

public struct CastlingOptions {
    public let isKingSideCastlingAvailable: Bool
    public let isQueenSideCastlingAvailable: Bool
    
    public init(isKingSideCastlingAvailable: Bool = false, isQueenSideCastlingAvailable: Bool = false) {
        self.isKingSideCastlingAvailable = isKingSideCastlingAvailable
        self.isQueenSideCastlingAvailable = isQueenSideCastlingAvailable
    }
}

public struct Pieces {
    public let king:    BitBoard
    public let queen:   BitBoard
    public let bishop:  BitBoard
    public let knight:  BitBoard
    public let rook:    BitBoard
    public let pawn:    BitBoard
    
    public var all: BitBoard {
        return king | queen | bishop | knight | rook | pawn
    }
    
    public init(king: BitBoard = .empty, queen: BitBoard = .empty, bishop: BitBoard = .empty, knight: BitBoard = .empty, rook: BitBoard = .empty, pawn: BitBoard = .empty) {
        self.king = king
        self.queen = queen
        self.bishop = bishop
        self.knight = knight
        self.rook = rook
        self.pawn = pawn
    }
}

public struct ChessBoard {

    public let nextMove:                PieceColor
    public let whitePieces:             Pieces
    public let blackPieces:             Pieces
    public let whiteCastlingOptions:    CastlingOptions
    public let blackCastlingOptions:    CastlingOptions
    public let enPassantTarget:         BitBoard.Index?
    public let halfMoveClock:           Int
    public let fullMoveNumber:          Int

    public init(nextMove: PieceColor = .white, whitePieces: Pieces = Pieces(), blackPieces: Pieces = Pieces(), whiteCastlingOptions: CastlingOptions = CastlingOptions(), blackCastlingOptions: CastlingOptions = CastlingOptions(), enPassantTarget: BitBoard.Index? = nil,  halfMoveClock: Int = 0, fullMoveNumber: Int = 0) {
        self.nextMove =                 nextMove
        self.whitePieces =              whitePieces
        self.blackPieces =              blackPieces
        self.whiteCastlingOptions =     whiteCastlingOptions
        self.blackCastlingOptions =     blackCastlingOptions
        self.enPassantTarget =          enPassantTarget
        self.halfMoveClock =            halfMoveClock
        self.fullMoveNumber =           fullMoveNumber
    }
    
    public static let standard: ChessBoard = {
        let fullCastlingOptions = CastlingOptions(isKingSideCastlingAvailable: true, isQueenSideCastlingAvailable: true)
        let whitePieces = Pieces(
            king: .e1,
            queen: .d1,
            bishop: BitBoard(.c1, .f1),
            knight: BitBoard(.b1, .g1),
            rook: BitBoard(.a1, .h1),
            pawn: BitBoard(.a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2))

        let blackPieces = Pieces(
            king: .e8,
            queen: .d8,
            bishop: BitBoard(.c8, .f8),
            knight: BitBoard(.b8, .g8),
            rook: BitBoard(.a8, .h8),
            pawn: BitBoard(.a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7))

        return ChessBoard(nextMove: .white, whitePieces: whitePieces, blackPieces: blackPieces, whiteCastlingOptions: fullCastlingOptions, blackCastlingOptions: fullCastlingOptions, enPassantTarget: nil, halfMoveClock: 0, fullMoveNumber: 0)
    }()
}

