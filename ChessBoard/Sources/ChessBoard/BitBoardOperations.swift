//  Created by Dusan Saiko (dusan@saiko.cz) on 22/08/2017.
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public extension BitBoard {
    
    var oneNorth:       BitBoard { return self << 8 }
    var oneSouth:       BitBoard { return self >> 8 }
    
    var oneEast:        BitBoard { return (self << 1) & ~Self.fileA }
    var oneNorthEast:   BitBoard { return (self << 9) & ~Self.fileA }
    var oneSouthEast:   BitBoard { return (self >> 7) & ~Self.fileA }
    
    var oneWest:        BitBoard { return (self >> 1) & ~Self.fileH }
    var oneSouthWest:   BitBoard { return (self >> 9) & ~Self.fileH }
    var oneNorthWest:   BitBoard { return (self << 7) & ~Self.fileH }
    
    var mirrorVertical: BitBoard {
        //return board with ranks (rows) in reverse order
        var result: BitBoard = 0
        let board = self
        
        result |= (board >> 56)   &  Self.rank1
        result |= ((board >> 48)  &  Self.rank1) << 8
        result |= ((board >> 40)  &  Self.rank1) << 16
        result |= ((board >> 32)  &  Self.rank1) << 24
        result |= ((board >> 24)  &  Self.rank1) << 32
        result |= ((board >> 16)  &  Self.rank1) << 40
        result |= ((board >> 8)   &  Self.rank1) << 48
        result |= (board          &  Self.rank1) << 56
        
        return result
    }
    
    var flipA1H8: BitBoard {
        //Flips around A1H8 diagonal
        let k1 = BitBoard(0x5500550055005500)
        let k2 = BitBoard(0x3333000033330000)
        let k4 = BitBoard(0x0f0f0f0f00000000)
        
        var b = self
        var t = k4 & (b ^ (b << 28))
        
        b ^= t ^ (t >> 28)
        t = k2 & (b ^ (b << 14))
        b ^= t ^ (t >> 14)
        t = k1 & (b ^ (b << 7))
        b ^= t ^ (t >> 7)

        return b
    }
    
    var mirrorHorizontal: BitBoard {
        //mirrors the bitboard horizontally
        let k1 = BitBoard(0x5555555555555555)
        let k2 = BitBoard(0x3333333333333333)
        let k4 = BitBoard(0x0f0f0f0f0f0f0f0f)
        
        var b = self
        b = ((b >> 1) & k1) | ((b & k1) << 1)
        b = ((b >> 2) & k2) | ((b & k2) << 2)
        b = ((b >> 4) & k4) | ((b & k4) << 4)
        
        return b
    }
    
    public var stringBoard: String {
        
        let header = "  a b c d e f g h\n"
        var result = ""
        let reversedRanks = self.mirrorVertical
        
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
            
            if(reversedRanks & (1 << i) != 0) {
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

