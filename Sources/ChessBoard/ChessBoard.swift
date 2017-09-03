//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

/**
     Representation of chess piece color.
     String enum with 'w' and 'b' values.
 */
public enum PieceColor: String {
    case white = "w"
    case black = "b"
}

/**
     Representation of chess piece.
     Enum of string values 'KQRBNP' respective 'kqrbnp'.
     Can return piece color.
 */
public enum Piece: String {
    case whiteKing      = "K"
    case whiteQueen     = "Q"
    case whiteRook      = "R"
    case whiteBishop    = "B"
    case whiteKnight    = "N"
    case whitePawn      = "P"

    case blackKing      = "k"
    case blackQueen     = "q"
    case blackRook      = "r"
    case blackBishop    = "b"
    case blackKnight    = "n"
    case blackPawn      = "p"

    public var color: PieceColor {
        switch self {
        case .whiteKing, .whiteQueen, .whiteRook, .whiteBishop, .whiteKnight, .whitePawn:
            return .white
        default:
            return .black
        }
    }
}

/**
     Castling options for a side.
 */
public struct CastlingOptions {
    public let isKingSideCastlingAvailable: Bool
    public let isQueenSideCastlingAvailable: Bool
    
    public init(isKingSideCastlingAvailable: Bool = false, isQueenSideCastlingAvailable: Bool = false) {
        self.isKingSideCastlingAvailable = isKingSideCastlingAvailable
        self.isQueenSideCastlingAvailable = isQueenSideCastlingAvailable
    }
}

/**
     Chess set for one side.
 */
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
        self.king   = king
        self.queen  = queen
        self.bishop = bishop
        self.knight = knight
        self.rook   = rook
        self.pawn   = pawn
    }
}

/**
 Chessboard representation
 */
public struct ChessBoard {

    public let nextMove:                PieceColor
    public let whitePieces:             Pieces
    public let blackPieces:             Pieces
    public let whiteCastlingOptions:    CastlingOptions
    public let blackCastlingOptions:    CastlingOptions
    public let enPassantTarget:         BitBoard.Index?
    public let halfMoveClock:           Int
    public let fullMoveNumber:          Int

    public var allPieces: BitBoard {
        return whitePieces.all | blackPieces.all
    }
    
    public init(
        nextMove: PieceColor = .white,
        whitePieces: Pieces = Pieces(),
        blackPieces: Pieces = Pieces(),
        whiteCastlingOptions: CastlingOptions = CastlingOptions(),
        blackCastlingOptions: CastlingOptions = CastlingOptions(),
        enPassantTarget: BitBoard.Index? = nil,
        halfMoveClock: Int = 0,
        fullMoveNumber: Int = 1)
    {
        self.nextMove =                 nextMove
        self.whitePieces =              whitePieces
        self.blackPieces =              blackPieces
        self.whiteCastlingOptions =     whiteCastlingOptions
        self.blackCastlingOptions =     blackCastlingOptions
        self.enPassantTarget =          enPassantTarget
        self.halfMoveClock =            halfMoveClock
        self.fullMoveNumber =           fullMoveNumber
    }
    
    /**
         Standard starting chessboard
     */
    public static let standard: ChessBoard = {
        let fullCastlingOptions = CastlingOptions(isKingSideCastlingAvailable: true, isQueenSideCastlingAvailable: true)
        
        let whitePieces = Pieces(
            king:   BitBoard(.e1),
            queen:  BitBoard(.d1),
            bishop: BitBoard(.c1, .f1),
            knight: BitBoard(.b1, .g1),
            rook:   BitBoard(.a1, .h1),
            pawn:   BitBoard(.a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2)
        )

        let blackPieces = Pieces(
            king:   BitBoard(.e8),
            queen:  BitBoard(.d8),
            bishop: BitBoard(.c8, .f8),
            knight: BitBoard(.b8, .g8),
            rook:   BitBoard(.a8, .h8),
            pawn:   BitBoard(.a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7)
        )

        return ChessBoard(
            nextMove:               .white,
            whitePieces:            whitePieces,
            blackPieces:            blackPieces,
            whiteCastlingOptions:   fullCastlingOptions,
            blackCastlingOptions:   fullCastlingOptions
        )
    }()
    
    /**
         All pieces as a dictionary of [Piece: BitBoard]
     */
    public var pieces: [Piece: BitBoard] {
        return [
            .whiteKing:     whitePieces.king,
            .whiteQueen:    whitePieces.queen,
            .whiteBishop:   whitePieces.bishop,
            .whiteKnight:   whitePieces.knight,
            .whiteRook:     whitePieces.rook,
            .whitePawn:     whitePieces.pawn,
            
            .blackKing:     blackPieces.king,
            .blackQueen:    blackPieces.queen,
            .blackBishop:   blackPieces.bishop,
            .blackKnight:   blackPieces.knight,
            .blackRook:     blackPieces.rook,
            .blackPawn:     blackPieces.pawn,
        ]
    }
}

