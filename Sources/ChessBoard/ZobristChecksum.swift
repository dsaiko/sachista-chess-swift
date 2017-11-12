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
        return x &* UInt64(2685821657736338717)
    }
}

class ZobristChecksum {

    static let rnd = PRNG(seed: 1070372)

    static let rndBlackSide             = ZobristChecksum.rnd.rand64()
    static let rndCastling              = ZobristChecksum.rndArray2D(ChessBoard.Color.count, ChessBoard.Piece.castlingOptions.count)
    static let rndEnPassantFile         = ZobristChecksum.rndArray(8) //TODO: magic 8
    static let rndPieces                = ZobristChecksum.rndArray3D(ChessBoard.Color.count, ChessBoard.Piece.count, 64) //TODO: Magic 64

    static func compute(board: ChessBoard) -> UInt64 {
        var checksum: UInt64 = 0
        
        //next move
        if board.sideToMove == .black {
            checksum ^= rndBlackSide
        }

        //castling
        ChessBoard.forAllCastlingOptions {
            color, piece in
            if board.castlingOptions[color][piece] {
                checksum ^= rndCastling[color][piece]
            }
        }

        //en passant
        if let enPassantTarget = board.enPassantTarget {
            let file = enPassantTarget.fileIndex
            checksum ^= rndEnPassantFile[file]
        }
        
        //pieces
        ChessBoard.forAllPieces() {
            color, piece in
            var bitboard = board.pieces[color][piece]
            
            while (bitboard != 0) {
                checksum ^= rndPieces[color][piece][bitboard.bitPop()]
            }
        }

        return checksum
    }
    
    private static func rndArray(_ size: Int) -> [UInt64] {
        var result = [UInt64](repeating: 0, count: size)
        for i in 0 ..< size {
            result[i] = ZobristChecksum.rnd.rand64()
        }
        return result
    }

    private static func rndArray2D(_ size1: Int, _ size2: Int) -> [[UInt64]] {
        var result = [[UInt64]]()
        for _ in 0 ..< size1 {
            result.append(rndArray(size2))
        }
        return result
    }
    
    private static func rndArray3D(_ size1: Int, _ size2: Int, _ size3: Int) -> [[[UInt64]]] {
        var result = [[[UInt64]]]()
        for _ in 0 ..< size1 {
            result.append(rndArray2D(size2, size3))
        }
        return result
    }

}

