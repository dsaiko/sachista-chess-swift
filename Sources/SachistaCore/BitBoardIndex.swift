//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

/**
 Representation of bit board index (for example c3) and its translation back to bit board
 */
public extension BitBoard {
    
    static private let a1NotationCodes = "a1".unicodeScalars.map{Int($0.value)}
    
    public enum Index: Int, CustomStringConvertible, Comparable {
        case a1 = 00; case b1 = 01; case c1 = 02; case d1 = 03; case e1 = 04; case f1 = 05; case g1 = 06; case h1 = 07
        case a2 = 08; case b2 = 09; case c2 = 10; case d2 = 11; case e2 = 12; case f2 = 13; case g2 = 14; case h2 = 15
        case a3 = 16; case b3 = 17; case c3 = 18; case d3 = 19; case e3 = 20; case f3 = 21; case g3 = 22; case h3 = 23
        case a4 = 24; case b4 = 25; case c4 = 26; case d4 = 27; case e4 = 28; case f4 = 29; case g4 = 30; case h4 = 31
        case a5 = 32; case b5 = 33; case c5 = 34; case d5 = 35; case e5 = 36; case f5 = 37; case g5 = 38; case h5 = 39
        case a6 = 40; case b6 = 41; case c6 = 42; case d6 = 43; case e6 = 44; case f6 = 45; case g6 = 46; case h6 = 47
        case a7 = 48; case b7 = 49; case c7 = 50; case d7 = 51; case e7 = 52; case f7 = 53; case g7 = 54; case h7 = 55
        case a8 = 56; case b8 = 57; case c8 = 58; case d8 = 59; case e8 = 60; case f8 = 61; case g8 = 62; case h8 = 63
        
        //TODO: make LAZY STATIC
        public var bitBoard: BitBoard {
            return 1 &<< self.rawValue
        }
        
        public var fileIndex: Int {
            return self.rawValue % 8
        }
        
        public var rankIndex: Int {
            return self.rawValue / 8
        }

        public init?(notation: String) {
            guard notation.count == 2 else {
                return nil
            }

            let values = notation.unicodeScalars.map{Int($0.value)}

            self.init(rawValue: Int(((values[0] &- BitBoard.a1NotationCodes[0]) &+ ((values[1] &- BitBoard.a1NotationCodes[1]) &<< 3))))
        }
        
        public var description: String {
            //can use unwrapped optionals as we know the values of enum cases
            let file = Character(UnicodeScalar(Int(self.rawValue % 8) &+ BitBoard.a1NotationCodes[0])!)
            let rank = Character(UnicodeScalar(Int(self.rawValue / 8) &+ BitBoard.a1NotationCodes[1])!)
            return "\(file)\(rank)"
        }
        
        public static func <(lhs: Index, rhs: Index) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
        public static func ==(lhs: Index, rhs: Index) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
}


