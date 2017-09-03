//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation


/// xorshift64star Pseudo-Random Number Generator
/// This class is based on original code written and dedicated
/// to the public domain by Sebastiano Vigna (2014).
/// It has the following characteristics:
///
///  -  Outputs 64-bit numbers
///  -  Passes Dieharder and SmallCrush test batteries
///  -  Does not require warm-up, no zeroland to escape
///  -  Internal state is a single 64-bit integer
///  -  Period is 2^64 - 1
///  -  Speed: 1.60 ns/call (Core i7 @3.40GHz)
///
/// For further analysis see
///   <http://vigna.di.unimi.it/ftp/papers/xorshift.pdf>

class PRNG {
    
    var x: UInt64
    
    init(seed: UInt64) {
        assert(seed > 0)
        x = seed
    }
    
    func rand64() -> UInt64 {
        x ^= x >> 12
        x ^= x << 25
        x ^= x >> 27
        return x * UInt64(2685821657736338717)
    }
}

class ZobristChecksum {

    static let rnd = PRNG(seed: 1070372)

    let rndBlackSide:           UInt64
    let rndCastlingWhiteKing:   UInt64
    let rndCastlingWhiteQueen:  UInt64
    let rndCastlingBlackKing:   UInt64
    let rndCastlingBlackQueen:  UInt64
    let rndEnPassantFile:       [UInt64]
    let rndWhitePieces:         [[UInt64]]
    let rndBlackPieces:         [[UInt64]]

    init() {
        
        rndBlackSide            = ZobristChecksum.rnd.rand64()
        rndCastlingWhiteKing    = ZobristChecksum.rnd.rand64()
        rndCastlingWhiteQueen   = ZobristChecksum.rnd.rand64()
        rndCastlingBlackKing    = ZobristChecksum.rnd.rand64()
        rndCastlingBlackQueen   = ZobristChecksum.rnd.rand64()
        rndEnPassantFile        = ZobristChecksum.rndArray(size: 8)
        rndWhitePieces          = ZobristChecksum.rndArray2D(size1: 6, size2: 64)
        rndBlackPieces          = ZobristChecksum.rndArray2D(size1: 6, size2: 64)
    }
    
    func compute(
        nextMove: PieceColor,
        whitePieces: Pieces,
        blackPieces: Pieces,
        whiteCastlingOptions: CastlingOptions,
        blackCastlingOptions: CastlingOptions,
        enPassantTarget: BitBoard.Index?
    ) -> UInt64 {
        var checksum: UInt64 = 0
        
        //next move
        if nextMove == .black {
            checksum ^= rndBlackSide
        }

        //castling
        if whiteCastlingOptions.isKingSideCastlingAvailable {
            checksum ^= rndCastlingWhiteKing
        }
        if whiteCastlingOptions.isQueenSideCastlingAvailable {
            checksum ^= rndCastlingWhiteQueen
        }
        if blackCastlingOptions.isKingSideCastlingAvailable {
            checksum ^= rndCastlingBlackKing
        }
        if blackCastlingOptions.isQueenSideCastlingAvailable {
            checksum ^= rndCastlingBlackQueen
        }

        //en passant
        if let enPassantTarget = enPassantTarget {
            let file = enPassantTarget.fileIndex
            checksum ^= rndEnPassantFile[file]
        }
        
        //white pieces
        var set = whitePieces
        for (index, var pieces) in [0: set.king, 1: set.queen, 2: set.bishop, 3: set.knight, 4: set.rook, 5: set.pawn] {
            while (pieces != 0) {
                checksum ^= rndWhitePieces[index][pieces.bitPop()]
            }
        }

        //black pieces
        set = blackPieces
        for (index, var pieces) in [0: set.king, 1: set.queen, 2: set.bishop, 3: set.knight, 4: set.rook, 5: set.pawn] {
            while (pieces != 0) {
                checksum ^= rndBlackPieces[index][pieces.bitPop()]
            }
        }

        return checksum
    }
    
    private static func rndArray(size: Int) -> [UInt64] {
        var result = [UInt64](repeating: 0, count: size)
        for i in 0 ..< size {
            result[i] = ZobristChecksum.rnd.rand64()
        }
        return result
    }

    private static func rndArray2D(size1: Int, size2: Int) -> [[UInt64]] {
        var result = [[UInt64]]()
        for _ in 0 ..< size1 {
            result.append(rndArray(size: size2))
        }
        return result
    }
}

