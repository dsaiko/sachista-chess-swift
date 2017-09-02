//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

extension ChessBoard: CustomStringConvertible {
    
    static let header = "  a b c d e f g h\n"

    private var mirroredPieces: [String: BitBoard] {
        return [
            "K": whitePieces.king.mirrorVertical,
            "Q": whitePieces.queen.mirrorVertical,
            "B": whitePieces.bishop.mirrorVertical,
            "N": whitePieces.knight.mirrorVertical,
            "R": whitePieces.rook.mirrorVertical,
            "P": whitePieces.pawn.mirrorVertical,
            
            "k": blackPieces.king.mirrorVertical,
            "q": blackPieces.queen.mirrorVertical,
            "b": blackPieces.bishop.mirrorVertical,
            "n": blackPieces.knight.mirrorVertical,
            "r": blackPieces.rook.mirrorVertical,
            "p": blackPieces.pawn.mirrorVertical,
        ]
    }

    public var description: String {
        var result = ChessBoard.header
        
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
                for (c, board) in mirroredPieces {
                    if (board & test) != 0 {
                        return c
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
    
    public var fenString: String {
        var result = ""

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
                for (c, board) in mirroredPieces {
                    if (board & test) != 0 {
                        return c
                    }
                }
                return nil
            }()

            outputItem(c)
        }
        outputItem("")
        
        // 2) Output next move
        result += " \(nextMove == .white ? "w" : "b")"

        // 3) output castling
        result += " "
        

//        if (castling[White] & KingSide)                   fen << 'K';
//        if (castling[White] & QueenSide)                  fen << 'Q';
//        if (castling[Black] & KingSide)                   fen << 'k';
//        if (castling[Black] & QueenSide)                  fen << 'q';
//        if ((castling[Black] | castling[White]) == 0)     fen << '-';
//        fen << ' ';
        
        return result
    }
}
