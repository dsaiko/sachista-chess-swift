//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

extension ChessBoard: CustomStringConvertible {
    
    static let header = "  a b c d e f g h\n"

    public var description: String {
        var result = ChessBoard.header
        
        let pieces = [
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
                for (c, board) in pieces {
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
}
