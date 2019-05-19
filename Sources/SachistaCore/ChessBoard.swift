//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public typealias PIECES_SET = (king: BitBoard, queen: BitBoard, bishop: BitBoard, knight: BitBoard, rook: BitBoard, pawn: BitBoard)
public typealias PIECES_ARRAY = (
    white: PIECES_SET,
    black: PIECES_SET
)

public typealias CASTLING_ARRAY =  (white: (kingside: Bool, queenside: Bool), black: (kingside: Bool, queenside: Bool))

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
    public let pieces:                  PIECES_ARRAY
    public let castlingOptions:         CASTLING_ARRAY
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
        pieces:                 PIECES_ARRAY        = ((.empty, .empty, .empty, .empty, .empty, .empty ), (.empty, .empty, .empty, .empty, .empty, .empty )),
        castlingOptions:        CASTLING_ARRAY      = ((false, false), (false, false)),
        enPassantTarget:        BitBoard.Index?     = nil,
        halfMoveClock:          Int                 = 0,
        fullMoveNumber:         Int                 = 1
    ) {
        self.sideToMove =                   sideToMove
        self.pieces =                       pieces
        self.castlingOptions =              castlingOptions
        self.enPassantTarget =              enPassantTarget
        self.halfMoveClock =                halfMoveClock
        self.fullMoveNumber =               fullMoveNumber
        
        self.opponentColor =                sideToMove == .white ? .black : .white
        self.whitePiecesBoard =             pieces.white.king | pieces.white.queen | pieces.white.rook | pieces.white.bishop | pieces.white.knight | pieces.white.pawn
        self.blackPiecesBoard =             pieces.black.king | pieces.black.queen | pieces.black.rook | pieces.black.bishop | pieces.black.knight | pieces.black.pawn
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
        let pieces  = (
            white: (
                king: BitBoard(.e1),
                queen: BitBoard(.d1),
                bishop: BitBoard(.c1, .f1),
                knight: BitBoard(.b1, .g1),
                rook: BitBoard(.a1, .h1),
                pawn: BitBoard(.a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2)
            ),
            black: (
                king: BitBoard(.e8),
                queen: BitBoard(.d8),
                bishop: BitBoard(.c8, .f8),
                knight: BitBoard(.b8, .g8),
                rook: BitBoard(.a8, .h8),
                pawn: BitBoard(.a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7)
            )
        )
        
        return ChessBoard(
            sideToMove:             .white,
            pieces:                 pieces,
            castlingOptions:        ((true, true), (true, true))
        )
    }()

    var mirroredVerticaly: ChessBoard {
        return modifyingPieces() {
            _, _, board in
            
            return board.mirrorVertical
        }
    }
    
    var mirroredHorizontaly: ChessBoard {
        return modifyingPieces() {
            _, _, board in
            
            return board.mirrorHorizontal
        }
    }
    
    @inline(__always) func piecesBy(color: Color) -> PIECES_SET {
        return color == .white ? pieces.white : pieces.black
    }

    @inline(__always) func boardBy(color: Color, piece: Piece) -> BitBoard {
        
        let pieces = piecesBy(color: color)
        
        switch piece {
        case .king:     return pieces.king
        case .queen:    return pieces.queen
        case .rook:     return pieces.rook
        case .knight:   return pieces.knight
        case .bishop:   return pieces.bishop
        case .pawn:     return pieces.pawn
        }
    }

    func iterateCastling(function: (Color, Piece, Bool) -> Void) {
        function(Color.white, Piece.king, castlingOptions.white.kingside)
        function(Color.black, Piece.king, castlingOptions.black.kingside)
        function(Color.white, Piece.queen, castlingOptions.white.queenside)
        function(Color.black, Piece.queen, castlingOptions.black.queenside)
    }

    func iteratePieces(function: (Color, Piece, BitBoard) -> Void) {
        function(Color.white, Piece.king, pieces.white.king)
        function(Color.white, Piece.queen, pieces.white.queen)
        function(Color.white, Piece.bishop, pieces.white.bishop)
        function(Color.white, Piece.rook, pieces.white.rook)
        function(Color.white, Piece.knight, pieces.white.knight)
        function(Color.white, Piece.pawn, pieces.white.pawn)
        
        function(Color.black, Piece.king, pieces.black.king)
        function(Color.black, Piece.queen, pieces.black.queen)
        function(Color.black, Piece.bishop, pieces.black.bishop)
        function(Color.black, Piece.rook, pieces.black.rook)
        function(Color.black, Piece.knight, pieces.black.knight)
        function(Color.black, Piece.pawn, pieces.black.pawn)
    }
    
    func modifyingPieces(color: Color? = nil, piece: Piece? = nil, function: @escaping (Color?, Piece?, BitBoard) -> BitBoard) -> ChessBoard {
        
        func functionIf(_ c: Color, _ p: Piece, _ board: BitBoard) -> BitBoard {
            return (color == nil || color == c) && (piece == nil || piece == p) ? function(c, p, board) : board
        }
        
        let modified  = (
            white: (
                king:   functionIf(Color.white, Piece.king, pieces.white.king),
                queen:  functionIf(Color.white, Piece.queen, pieces.white.queen),
                bishop: functionIf(Color.white, Piece.bishop, pieces.white.bishop),
                knight: functionIf(Color.white, Piece.knight, pieces.white.knight),
                rook:   functionIf(Color.white, Piece.rook, pieces.white.rook),
                pawn:   functionIf(Color.white, Piece.pawn, pieces.white.pawn)
            ),
            black: (
                king:   functionIf(Color.black, Piece.king, pieces.black.king),
                queen:  functionIf(Color.black, Piece.queen, pieces.black.queen),
                bishop: functionIf(Color.black, Piece.bishop, pieces.black.bishop),
                knight: functionIf(Color.black, Piece.knight, pieces.black.knight),
                rook:   functionIf(Color.black, Piece.rook, pieces.black.rook),
                pawn:   functionIf(Color.black, Piece.pawn, pieces.black.pawn)
            )
        )
        
        return ChessBoard(
            sideToMove:             sideToMove,
            pieces:                 modified,
            castlingOptions:        castlingOptions,
            enPassantTarget:        enPassantTarget,
            halfMoveClock:          halfMoveClock,
            fullMoveNumber:         fullMoveNumber
        )
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
