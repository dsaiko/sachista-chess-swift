//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

/**
 Protocol used for perfomance results caching
 Checksum is a ChessBoard hash (ZobristKey),
 depth is a search depth for which is the count relevant.
 */
public protocol PerfTCache {
    func put(checksum: UInt64, depth: Int, count: UInt64)
    func get(checksum: UInt64, depth: Int) -> UInt64?
}

public extension ChessBoard {

    /**
     Simple PerfT in-memory cache
    */
    public final class SimplePerfTCache: PerfTCache {
        
        /**
         Cache record
         */
        private struct Record {
            let checksum:   UInt64
            let depth:      Int
            let count:      UInt64
        }
        
        /**
         Shared in-memory cache of default size
        */
        public static let `default` = SimplePerfTCache(cacheSize: 16*1024*1024)

        /**
         Used for computing index keys. If cacheSize is too small, index keys will start repeating
        */
        private let cacheSize: UInt64
        
        /**
         On macos 10.13.1, Swift 4, dictionary is of the same performance as self managed fixed-size hash array
         Dictionary has advantage of no overflow errors.
        */
        private var cache: [UInt64: Record]
        
        /**
         - Parameter cacheSize: size of cache in records
        */
        public init(cacheSize: UInt64) {
            self.cacheSize = cacheSize
            self.cache = [:]
        }
        
        /**
         Index of the record
        */
        private func index(checksum: UInt64, depth: Int) -> UInt64 {
            return (cacheSize - 1 - UInt64(depth)) & checksum
        }
        
        public func put(checksum: UInt64, depth: Int, count: UInt64) {
            cache[index(checksum: checksum, depth: depth)] = Record(checksum: checksum, depth: depth, count: count)
        }
        
        public func get(checksum: UInt64, depth: Int) -> UInt64? {
            if let record = cache[index(checksum: checksum, depth: depth)],
               record.checksum == checksum,
               record.depth == depth
            {
                return record.count
            } else {
                return nil
            }
        }
    }
    
    //TODO: implement multi threading
    public func perft(depth: Int, cache: PerfTCache = SimplePerfTCache.default) -> UInt64 {
        
        if(depth < 1) { return 1 }
        
        if let cache = cache.get(checksum: zobristChecksum, depth: depth) {
            return cache
        }
        
        var count: UInt64 = 0
        
        let attacks = self.attacks(color: opponentColor)
        let isCheck = (attacks & self.kingBoard) != 0
        
        for move in pseudoLegalMoves() {
            let sourceBitBoard = move.from.bitBoard
            let isKingMove = move.piece == . whiteKing || move.piece == .blackKing
            
            if isKingMove || isCheck || ((sourceBitBoard & attacks) != 0) || move.isEnpassant {
                //need to validate move
                
                let nextBoard = makeMove(move: move)
                if !nextBoard.isOpponentsKingUnderCheck() {
                    if depth == 1 {
                        count += 1
                    } else {
                        count += nextBoard.perft(depth: depth - 1)
                    }
                }
            } else {
                if depth == 1 {
                    count += 1
                } else {
                    //do not need to validate legality of the move
                    let nextBoard = makeMove(move: move)
                    count += nextBoard.perft(depth: depth - 1)
                }
            }
        }
        
        cache.put(checksum: zobristChecksum, depth: depth, count: count)
        return count
    }
    
}





