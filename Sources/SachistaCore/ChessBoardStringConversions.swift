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
        
        let mirroredPieces = self.mirrorVertical().pieces
        
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
            
            let test: BitBoard = 1 &<< i
            
            let c: String? = {
                var description: String? = nil
                
                ChessBoard.forAllPieces() {
                    color, piece in
                    if (mirroredPieces[color][piece] & test) != 0 {
                        description = piece.description(color: color)
                    }
                }

                return description
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

        let mirroredPieces = self.mirrorVertical().pieces
        
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
            
            let test: BitBoard = 1 &<< i
            
            let c: String? = {
                var description: String? = nil
                
                ChessBoard.forAllPieces() {
                    color, piece in
                    if (mirroredPieces[color][piece] & test) != 0 {
                        description = piece.description(color: color)
                    }
                }
                
                return description
            }()

            outputItem(c)
        }
        outputItem("")
        
        // 2) Output next move
        result += " \(sideToMove.description) "

        // 3) output castling
        var castling = ""
        castling += castlingOptions[Color.white][ChessBoard.Piece.king]    ?   Piece.king.description(color: .white)   : ""
        castling += castlingOptions[Color.white][ChessBoard.Piece.queen]   ?   Piece.queen.description(color: .white)  : ""
        castling += castlingOptions[Color.black][ChessBoard.Piece.king]    ?   Piece.king.description(color: .black)   : ""
        castling += castlingOptions[Color.black][ChessBoard.Piece.queen]   ?   Piece.queen.description(color: .black)  : ""

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
    public init?(fenString: String) {
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
                    //shift all pieces
                    ChessBoard.forAllPieces() {
                        color, piece in
                        pieces[color][piece] &<<= spaces
                    }
                } else {
                    return nil
                }
            } else {
                let char = String(c)
                let color: Color = char.uppercased() == char ? .white : .black
                guard let piece = Piece.values.first(where: { $0.description(color: color) == char }) else {
                    return nil
                }

                //shift all pieces
                ChessBoard.forAllPieces() {
                    color, piece in
                    pieces[color][piece] &<<= 1
                }

                pieces[color][piece] |= 1
            }
        }
        
        pieces = ChessBoard(pieces: pieces).mirrorHorizontal().pieces

        // 2) next move color
        let color = String(sections.removeFirst())
        guard let sideToMove = Color.values.first(where: {$0.description == color }) else {
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
                case Piece.king.description(color: .white):
                    whiteKingCastling = true
                case Piece.queen.description(color: .white):
                    whiteQueenCastling = true
                case Piece.king.description(color: .black):
                    blackKingCastling = true
                case Piece.queen.description(color: .black):
                    blackQueenCastling = true
                default:
                    return nil
                }
            }
        }
        
        //castling correction
        whiteKingCastling  =  whiteKingCastling     && ((pieces[Color.white][Piece.king] & .e1) != .empty) && ((pieces[Color.white][Piece.rook] & .h1) != .empty)
        whiteQueenCastling =  whiteQueenCastling    && ((pieces[Color.white][Piece.king] & .e1) != .empty) && ((pieces[Color.white][Piece.rook] & .a1) != .empty)
        blackKingCastling  =  blackKingCastling     && ((pieces[Color.black][Piece.king] & .e8) != .empty) && ((pieces[Color.black][Piece.rook] & .h8) != .empty)
        blackQueenCastling =  blackQueenCastling    && ((pieces[Color.black][Piece.king] & .e8) != .empty) && ((pieces[Color.black][Piece.rook] & .a8) != .empty)

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
            sideToMove:             sideToMove,
            pieces:                 pieces,
            castlingOptions:        [[whiteKingCastling, whiteQueenCastling], [blackKingCastling, blackQueenCastling]],
            enPassantTarget:        enPassantTarget,
            halfMoveClock:          halfMoveClock,
            fullMoveNumber:         fullMoveNumber
        )
    }
}
