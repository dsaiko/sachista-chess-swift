//
//  Mask.swift
//  Created by Dusan Saiko on 22/08/2017.
//

import Foundation

public class Mask {

    public static let a1 = UInt64(1) << 0
    public static let b1 = UInt64(1) << 1
    public static let c1 = UInt64(1) << 2
    public static let d1 = UInt64(1) << 3
    public static let e1 = UInt64(1) << 4
    public static let f1 = UInt64(1) << 5
    public static let g1 = UInt64(1) << 6
    public static let h1 = UInt64(1) << 7
    public static let a2 = UInt64(1) << 8
    public static let b2 = UInt64(1) << 9
    public static let c2 = UInt64(1) << 10
    public static let d2 = UInt64(1) << 11
    public static let e2 = UInt64(1) << 12
    public static let f2 = UInt64(1) << 13
    public static let g2 = UInt64(1) << 14
    public static let h2 = UInt64(1) << 15
    public static let a3 = UInt64(1) << 16
    public static let b3 = UInt64(1) << 17
    public static let c3 = UInt64(1) << 18
    public static let d3 = UInt64(1) << 19
    public static let e3 = UInt64(1) << 20
    public static let f3 = UInt64(1) << 21
    public static let g3 = UInt64(1) << 22
    public static let h3 = UInt64(1) << 23
    public static let a4 = UInt64(1) << 24
    public static let b4 = UInt64(1) << 25
    public static let c4 = UInt64(1) << 26
    public static let d4 = UInt64(1) << 27
    public static let e4 = UInt64(1) << 28
    public static let f4 = UInt64(1) << 29
    public static let g4 = UInt64(1) << 30
    public static let h4 = UInt64(1) << 31
    public static let a5 = UInt64(1) << 32
    public static let b5 = UInt64(1) << 33
    public static let c5 = UInt64(1) << 34
    public static let d5 = UInt64(1) << 35
    public static let e5 = UInt64(1) << 36
    public static let f5 = UInt64(1) << 37
    public static let g5 = UInt64(1) << 38
    public static let h5 = UInt64(1) << 39
    public static let a6 = UInt64(1) << 40
    public static let b6 = UInt64(1) << 41
    public static let c6 = UInt64(1) << 42
    public static let d6 = UInt64(1) << 43
    public static let e6 = UInt64(1) << 44
    public static let f6 = UInt64(1) << 45
    public static let g6 = UInt64(1) << 46
    public static let h6 = UInt64(1) << 47
    public static let a7 = UInt64(1) << 48
    public static let b7 = UInt64(1) << 49
    public static let c7 = UInt64(1) << 50
    public static let d7 = UInt64(1) << 51
    public static let e7 = UInt64(1) << 52
    public static let f7 = UInt64(1) << 53
    public static let g7 = UInt64(1) << 54
    public static let h7 = UInt64(1) << 55
    public static let a8 = UInt64(1) << 56
    public static let b8 = UInt64(1) << 57
    public static let c8 = UInt64(1) << 58
    public static let d8 = UInt64(1) << 59
    public static let e8 = UInt64(1) << 60
    public static let f8 = UInt64(1) << 61
    public static let g8 = UInt64(1) << 62
    public static let h8 = UInt64(1) << 63

    public static let rank: [UInt64] = [
        a1 | b1 | c1 | d1 | e1 | f1 | g1 | h1,
        a2 | b2 | c2 | d2 | e2 | f2 | g2 | h2,
        a3 | b3 | c3 | d3 | e3 | f3 | g3 | h3,
        a4 | b4 | c4 | d4 | e4 | f4 | g4 | h4,
        a5 | b5 | c5 | d5 | e5 | f5 | g5 | h5,
        a6 | b6 | c6 | d6 | e6 | f6 | g6 | h6,
        a7 | b7 | c7 | d7 | e7 | f7 | g7 | h7,
        a8 | b8 | c8 | d8 | e8 | f8 | g8 | h8
    ]

    public static let file: [UInt64] = [
        a1 | a2 | a3 | a4 | a5 | a6 | a7 | a8,
        b1 | b2 | b3 | b4 | b5 | b6 | b7 | b8,
        c1 | c2 | c3 | c4 | c5 | c6 | c7 | c8,
        d1 | d2 | d3 | d4 | d5 | d6 | d7 | d8,
        e1 | e2 | e3 | e4 | e5 | e6 | e7 | e8,
        f1 | f2 | f3 | f4 | f5 | f6 | f7 | f8,
        g1 | g2 | g3 | g4 | g5 | g6 | g7 | g8,
        h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
    ]

    public static let fileA = file[0]
    public static let fileH = file[7]

    public static let rank1 = rank[0]
    public static let rank8 = rank[7]

    public static let frame = rank1 | rank8 | fileA | fileH
    
    public static let universe = ~UInt64(0)
    public static let empty = UInt64(0)

    public static let a1h8: [UInt64] = [
        a8,
        a7 | b8,
        a6 | b7 | c8,
        a5 | b6 | c7 | d8,
        a4 | b5 | c6 | d7 | e8,
        a3 | b4 | c5 | d6 | e7 | f8,
        a2 | b3 | c4 | d5 | e6 | f7 | g8,
        a1 | b2 | c3 | d4 | e5 | f6 | g7 | h8,
        b1 | c2 | d3 | e4 | f5 | g6 | h7,
        c1 | d2 | e3 | f4 | g5 | h6,
        d1 | e2 | f3 | g4 | h5,
        e1 | f2 | g3 | h4,
        f1 | g2 | h3,
        g1 | h2,
        h1
    ]
    
    public static let a8h1: [UInt64] = [
        a1,
        a2 | b1,
        a3 | b2 | c1,
        a4 | b3 | c2 | d1,
        a5 | b4 | c3 | d2 | e1,
        a6 | b5 | c4 | d3 | e2 | f1,
        a7 | b6 | c5 | d4 | e3 | f2 | g1,
        a8 | b7 | c6 | d5 | e4 | f3 | g2 | h1,
        b8 | c7 | d6 | e5 | f4 | g3 | h2,
        c8 | d7 | e6 | f5 | g4 | h3,
        d8 | e7 | f6 | g5 | h4,
        e8 | f7 | g6 | h5,
        f8 | g7 | h6,
        g8 | h7,
        h8
    ]
}

