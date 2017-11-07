//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

extension ChessBoard: CustomStringConvertible {
    
    static let header = "  a b c d e f g h\n"

    /**
     Convert chessboard to string
     */
    public var description: String {
        var result = ChessBoard.header
        
        let mirroredPieces = pieces.flatMap {
            return [$0: $1.mirrorVertical]
        }
        
        for i in 0 ..< BitBoard.bitWidth {
            if (i % 8) == 0 {
                if (i > 0) {
                    //print right column digit
                    result += "\(9 - (i / 8))"
                    result += "\n"
                }
                
                //print left column digit
                result += "\(8 - (i / 8))"
                result += " "
            }
            
            let test: BitBoard = 1 << i
            
            let c: String? = {
                for (piece, board) in mirroredPieces {
                    if (board & test) != 0 {
                        return piece.description
                    }
                }
                return nil
            }()
            
            result += "\(c ?? "-") "
        }
        
        result += "1\n" //last right column digit
        result += ChessBoard.header //footer
        
        return result
    }
    
    /**
         Get FEN from the chessboard
    */
    public var fenString: String {
        var result = ""

        let mirroredPieces = pieces.flatMap {
            return [$0: $1.mirrorVertical]
        }
        
        // 1) Output board setup
        var emptyCount = 0
        func outputItem(_ c: String?) {
            if let c = c {
                //if char is set, output number of previous empty places plus char
                if emptyCount > 0 {
                    result += "\(emptyCount)"
                    emptyCount = 0
                }
                result += c
            } else {
                //increment number of empty spaces
                emptyCount += 1
            }
        }
        
        for i in 0 ..< BitBoard.bitWidth {
            if (i > 0) && (i % 8 == 0) {
                outputItem("/")
            }
            
            let test: BitBoard = 1 << i
            
            let c: String? = {
                for (piece, board) in mirroredPieces {
                    if (board & test) != 0 {
                        return piece.description
                    }
                }
                return nil
            }()

            outputItem(c)
        }
        outputItem("")
        
        // 2) Output next move
        result += " \(nextMove == .white ? Piece.Color.white.rawValue : Piece.Color.black.rawValue) "

        // 3) output castling
        var castling = ""
        castling += whiteCastlingOptions.isKingSideCastlingAvailable ? Piece.whiteKing.description : ""
        castling += whiteCastlingOptions.isQueenSideCastlingAvailable ? Piece.whiteQueen.description : ""
        castling += blackCastlingOptions.isKingSideCastlingAvailable ? Piece.blackKing.description : ""
        castling += blackCastlingOptions.isQueenSideCastlingAvailable ? Piece.blackQueen.description : ""

        result += castling.isEmpty ? "-" : castling

        // 4) enPassant target
        result += " \(enPassantTarget.flatMap({"\($0)"}) ?? "-")"
        
        // 5) half move clock
        result += " \(halfMoveClock)"

        // 7) full move number
        result += " \(fullMoveNumber)"

        return result
    }
    
    /**
         Create chessboard from FEN
     */
    convenience public init?(fenString: String) {
        var sections = fenString.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        if sections.count != 4 && sections.count != 6 {
            return nil
        }
        
        //all will be empty
        var pieces = ChessBoard().pieces

        // 1) pieces
        if sections[0].split(separator: "/").count != 8 {
            return nil
        }
        
        for c in sections.removeFirst() {
            if c == "/" { continue }
            
            if let spaces = Int(String(c)) {
                //if number of spaces
                if spaces > 0 && spaces <= 8 {
                    for piece in pieces.keys {
                        pieces[piece]! <<= spaces
                    }
                } else {
                    return nil
                }
            } else if let piece = Piece(description: String(c))  {
                for piece in pieces.keys {
                    pieces[piece]! <<= 1
                }

                pieces[piece]! |= 1
            } else {
                return nil
            }
        }
        
        let whitePieces = Pieces(
            king:   pieces[.whiteKing]!.mirrorHorizontal,
            queen:  pieces[.whiteQueen]!.mirrorHorizontal,
            bishop: pieces[.whiteBishop]!.mirrorHorizontal,
            knight: pieces[.whiteKnight]!.mirrorHorizontal,
            rook:   pieces[.whiteRook]!.mirrorHorizontal,
            pawn:   pieces[.whitePawn]!.mirrorHorizontal
        )
        
        let blackPieces = Pieces(
            king:   pieces[.blackKing]!.mirrorHorizontal,
            queen:  pieces[.blackQueen]!.mirrorHorizontal,
            bishop: pieces[.blackBishop]!.mirrorHorizontal,
            knight: pieces[.blackKnight]!.mirrorHorizontal,
            rook:   pieces[.blackRook]!.mirrorHorizontal,
            pawn:   pieces[.blackPawn]!.mirrorHorizontal
        )

        // 2) next move color
        guard let nextMove = Piece.Color(rawValue: String(sections.removeFirst())) else {
            return nil
        }
        
        // 3) castling
        var whiteKingCastling: Bool = false
        var whiteQueenCastling: Bool = false
        var blackKingCastling: Bool = false
        var blackQueenCastling: Bool = false

        let castling = sections.removeFirst()
        if castling != "-" {
            for c in castling {
                switch String(c) {
                case Piece.whiteKing.description:
                    whiteKingCastling = true
                case Piece.whiteQueen.description:
                    whiteQueenCastling = true
                case Piece.blackKing.description:
                    blackKingCastling = true
                case Piece.blackQueen.description:
                    blackQueenCastling = true
                default:
                    return nil
                }
            }
        }
        //castling correction
        whiteKingCastling  =  whiteKingCastling && ((whitePieces.king & .e1) != .empty) && ((whitePieces.rook & .h1) != .empty)
        whiteQueenCastling =  whiteQueenCastling && ((whitePieces.king & .e1) != .empty) && ((whitePieces.rook & .a1) != .empty)
        blackKingCastling  =  blackKingCastling && ((blackPieces.king & .e8) != .empty) && ((blackPieces.rook & .h8) != .empty)
        blackQueenCastling =  blackQueenCastling && ((blackPieces.king & .e8) != .empty) && ((blackPieces.rook & .a8) != .empty)

        // 4) enPassantTarget
        let enPassantTargetString = sections.removeFirst()
        var enPassantTarget: BitBoard.Index?
        
        if enPassantTargetString != "-" {
            enPassantTarget = BitBoard.Index(notation: String(enPassantTargetString))
            if enPassantTarget == nil {
                return nil
            }
        }
        
        // 5) half move clock - not mandatory
        var halfMoveClock = 0
        if sections.count > 0 {
            if let value = Int(String(sections.removeFirst())), value >= 0
            {
                halfMoveClock = value
            } else {
                return nil
            }
        }
        
        // 6) Full move number - not mandatory
        var fullMoveNumber = 1
        if sections.count > 0 {
            if let value = Int(String(sections.removeFirst())), value >= 1
            {
                fullMoveNumber = value
            } else {
                return nil
            }
        }
        
        self.init(
            nextMove:               nextMove,
            whitePieces:            whitePieces,
            blackPieces:            blackPieces,
            whiteCastlingOptions:   CastlingOptions(isKingSideCastlingAvailable: whiteKingCastling, isQueenSideCastlingAvailable: whiteQueenCastling),
            blackCastlingOptions:   CastlingOptions(isKingSideCastlingAvailable: blackKingCastling, isQueenSideCastlingAvailable: blackQueenCastling),
            enPassantTarget:        enPassantTarget,
            halfMoveClock:          halfMoveClock,
            fullMoveNumber:         fullMoveNumber
        )
    }
}
