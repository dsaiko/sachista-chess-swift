//
//  Board.swift
//  Created by Dusan Saiko on 22/08/2017.
//

import Foundation

public class Board {
    
    public static func reverseRanks(board: UInt64) -> UInt64 {
        //return board with ranks (rows) in reverse order
        var result: UInt64 = 0
        
        result |= (board >> 56)   &  Mask.rank1
        result |= ((board >> 48)  &  Mask.rank1) << 8
        result |= ((board >> 40)  &  Mask.rank1) << 16
        result |= ((board >> 32)  &  Mask.rank1) << 24
        result |= ((board >> 24)  &  Mask.rank1) << 32
        result |= ((board >> 16)  &  Mask.rank1) << 40
        result |= ((board >> 8)   &  Mask.rank1) << 48
        result |= (board          &  Mask.rank1) << 56
        
        return result
    }
    
    public static func toString(board: UInt64) -> String {
        let header = "  a b c d e f g h\n"
        var result = ""
        
        let reversedBoard = reverseRanks(board: board)
        
        result += header
        
        for i in 0..<64 {
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
            
            if(reversedBoard & (1 << i) != 0) {
                result += "x "
            } else {
                result += "- "
            }
        }
        
        result += "1\n" //last right column digit
        result += header //footer
        
        return result
    }
}

