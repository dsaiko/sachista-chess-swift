//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public extension BitBoard {
    
    public var oneNorth:       BitBoard { return self << 8 }
    public var oneSouth:       BitBoard { return self >> 8 }
    
    public var oneEast:        BitBoard { return (self << 1) & ~.fileA }
    public var oneNorthEast:   BitBoard { return (self << 9) & ~.fileA }
    public var oneSouthEast:   BitBoard { return (self >> 7) & ~.fileA }
    
    public var oneWest:        BitBoard { return (self >> 1) & ~.fileH }
    public var oneSouthWest:   BitBoard { return (self >> 9) & ~.fileH }
    public var oneNorthWest:   BitBoard { return (self << 7) & ~.fileH }

    public func shift(dx: Int, dy: Int) -> BitBoard {
        var board = self
        
        //up or down
        if dy > 0 { board <<= dy * 8 }
        if dy < 0 { board >>= (-dy) * 8 }
        
        //left / right
        for _ in 0 ..< dx { board = board.oneEast }
        for _ in 0 ..< -dx { board = board.oneWest }

        return board
    }
    
    
    public var mirrorVertical: BitBoard {
        //return board with ranks (rows) in reverse order
        var result: BitBoard = 0
        let board = self
        
        result |= (board >> 56)   &  .rank1
        result |= ((board >> 48)  &  .rank1) << 8
        result |= ((board >> 40)  &  .rank1) << 16
        result |= ((board >> 32)  &  .rank1) << 24
        result |= ((board >> 24)  &  .rank1) << 32
        result |= ((board >> 16)  &  .rank1) << 40
        result |= ((board >> 8)   &  .rank1) << 48
        result |= (board          &  .rank1) << 56
        
        return result
    }
    
    public var flipA1H8: BitBoard {
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
    
    public var mirrorHorizontal: BitBoard {
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
    
    /**
     BitBoard as string representation
     - Note: can not override description from UInt64
     */
    public var stringBoard: String {
        let reversedRanks = self.mirrorVertical
        var result = ""
        
        result += ChessBoard.header
        
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
            
            if(reversedRanks & (1 << i) != 0) {
                result += "x "
            } else {
                result += "- "
            }
        }
        
        result += "1\n" //last right column digit
        result += ChessBoard.header //footer
        
        return result
    }
    
    /**
     Returns all fields which are set on the board as array of BitBoard.Index
     */
    public var indeces: [Index] {
        var result = [Index]()
        
        var board = self
        while board != 0 {
            result.append(board.bitPop())
        }
        
        return result
    }
    
    /**
     - Returns: Index of first bit set. This bit is reset on "self"
     - Requires: self != 0
     */
    public mutating func bitPop() -> BitBoard.Index {
        assert(self != 0)
        
        let i = self.trailingZeroBitCount
        self &= self - 1
        
        //TODO PERFORMANCE: Int?
        return BitBoard.Index(rawValue: i)!
    }
}

