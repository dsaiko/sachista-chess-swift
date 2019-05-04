//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

/**
 Chessboard representation
 */
public struct ChessBoard {

    /**
     Representation of chess piece color.
     String enum with 'w' and 'b' values.
     */
    public enum Color: Int {
        case white = 0
        case black = 1

        public static let values: [Color] = [.white, .black]
        public static let count: Int = { return values.count }()

        var description: String {
            switch self {
                case .white: return "w"
                case .black: return "b"
            }
        }
        
    }

    public enum Piece: Int {
        case king = 0
        case queen
        case bishop
        case knight
        case rook
        case pawn
        
        public static let values: [Piece] = [.king, .queen, .bishop, .knight, .rook, .pawn]
        public static let count: Int = { return values.count }()
        public static let castlingOptions: [Piece] = [.king, .queen]
        
        func description(color: Color) -> String {
            switch color {
                case .white:
                    switch self {
                        case .king:      return "K"
                        case .queen:     return "Q"
                        case .bishop:    return "B"
                        case .knight:    return "N"
                        case .rook:      return "R"
                        case .pawn:      return "P"
                    }
                case .black:
                    switch self {
                        case .king:      return "k"
                        case .queen:     return "q"
                        case .bishop:    return "b"
                        case .knight:    return "n"
                        case .rook:      return "r"
                        case .pawn:      return "p"
                    }
            }
        }
     }
    
    public let sideToMove:              Color
    //TODO: test [Color: [Piece: BitBoard]]
    public let pieces:                  [[BitBoard]]
    public let castlingOptions:         [[Bool]]
    public let enPassantTarget:         BitBoard.Index?
    public let halfMoveClock:           Int
    public let fullMoveNumber:          Int
    
    public let opponentColor:                Color
    public let whitePiecesBoard:             BitBoard
    public let blackPiecesBoard:             BitBoard
    public let allPiecesBoard:               BitBoard
    public let noPiecesBoard:                BitBoard
    public let emptyOrOpponentPiecesBoard:   BitBoard
    public let opponentPiecesBoard:          BitBoard


    static let moveGenerators: [MoveGenerator] = [
        MoveGeneratorPawn(),
        MoveGeneratorKing(),
        MoveGeneratorKnight(),
        MoveGeneratorRook(),
        MoveGeneratorBishop()
    ]
    
    public init(
        sideToMove:             Color               = .white,
        pieces:                 [[BitBoard]]        = [[BitBoard]](repeating: [BitBoard](repeating: .empty, count: ChessBoard.Piece.count), count: ChessBoard.Color.count),
        castlingOptions:        [[Bool]]            = [[Bool]](repeating: [Bool](repeating: false, count: Piece.castlingOptions.count), count: ChessBoard.Color.count),
        enPassantTarget:        BitBoard.Index?     = nil,
        halfMoveClock:          Int                 = 0,
        fullMoveNumber:         Int                 = 1
    ) {
//        assert(pieces.count                         == ChessBoard.Color.count)
//        assert(pieces[Color.white].count            == ChessBoard.Piece.count)
//        assert(pieces[Color.black].count            == ChessBoard.Piece.count)
//        assert(castlingOptions.count                == ChessBoard.Color.count)
//        assert(castlingOptions[Color.white].count   == Piece.castlingOptions.count)
//        assert(castlingOptions[Color.black].count   == Piece.castlingOptions.count)

        self.sideToMove =                   sideToMove
        self.pieces =                       pieces
        self.castlingOptions =              castlingOptions
        self.enPassantTarget =              enPassantTarget
        self.halfMoveClock =                halfMoveClock
        self.fullMoveNumber =               fullMoveNumber
        
        self.opponentColor =                sideToMove == .white ? .black : .white
        self.whitePiecesBoard =             pieces[Color.white].reduce(0, { $0 | $1 })
        self.blackPiecesBoard =             pieces[Color.black].reduce(0, { $0 | $1 })
        self.allPiecesBoard =               whitePiecesBoard | blackPiecesBoard
        self.noPiecesBoard =                ~allPiecesBoard
        self.emptyOrOpponentPiecesBoard =   sideToMove == .white ? ~whitePiecesBoard : ~blackPiecesBoard
        self.opponentPiecesBoard =          sideToMove == .white ? blackPiecesBoard : whitePiecesBoard
    }
    
    func isBitmaskUnderAttack(color: Color, board: BitBoard) -> Bool {
        //TODO PERFORMANCE: order of moveGenerators
        //TODO PERFORMANCE: lazy var instead of loop? how many times this is called?
        //TODO PERFORMANCE: is this used only for castling?
        //TODO try functional variant
        for moveGenerator in ChessBoard.moveGenerators {
            if (moveGenerator.attacks(board: self, color: color) & board) != 0 {
                return true
            }
        }
        
        return false
    }
    
    /**
         Standard starting chessboard
     */
    public static let standard: ChessBoard = {
        let fullCastlingOptions  = [ [true, true], [true, true] ]
        let pieces: [[BitBoard]] = [
            [
                BitBoard(.e1), //king
                BitBoard(.d1), //queen
                BitBoard(.c1, .f1), //bishop
                BitBoard(.b1, .g1), //knight
                BitBoard(.a1, .h1), //rook
                BitBoard(.a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2) //pawn
            ],
            [
                BitBoard(.e8), //king
                BitBoard(.d8), //queen
                BitBoard(.c8, .f8), //bishop
                BitBoard(.b8, .g8), //knight
                BitBoard(.a8, .h8), //rook
                BitBoard(.a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7) //pawn
            ]
        ]
        
        return ChessBoard(
            sideToMove:             .white,
            pieces:                 pieces,
            castlingOptions:        fullCastlingOptions
        )
    }()
    
    //TODO: fnc vs prop
    func mirrorVertical() -> ChessBoard {
        var pieces = self.pieces
        
        //pieces
        ChessBoard.forAllPieces() {
            color, piece in
            pieces[color][piece] = pieces[color][piece].mirrorVertical
        }
        
        return ChessBoard(
            sideToMove:             sideToMove,
            pieces:                 pieces,
            castlingOptions:        castlingOptions
        )
    }
    
    //TODO: fnc vs prop
    func mirrorHorizontal() -> ChessBoard {
        var pieces = self.pieces
        
        //pieces
        ChessBoard.forAllPieces() {
            color, piece in
            pieces[color][piece] = pieces[color][piece].mirrorHorizontal
        }
        
        return ChessBoard(
            sideToMove:             sideToMove,
            pieces:                 pieces,
            castlingOptions:        castlingOptions
        )
    }
    
    static func forAllPieces(function: (Color, Piece) -> Void) {
        for color in Color.values {
            for piece in ChessBoard.Piece.values {
                function(color, piece)
            }
        }
    }
    
    static func forAllCastlingOptions(function: (Color, Piece) -> Void) {
        for color in Color.values {
            for piece in ChessBoard.Piece.castlingOptions {
                function(color, piece)
            }
        }
    }
}

extension Array {
    subscript<T: RawRepresentable>(index: T) -> Element where T.RawValue == Int  {
        get {
            return self[index.rawValue] //TODO: remove .rawValue from everywhere
        }
        set(newValue) {
            self[index.rawValue] = newValue
        }
    }
}
