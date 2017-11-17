//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

/**
 Protocol used for perfomance results caching
 Checksum is a ChessBoard hash (ZobristKey),
 depth is a search depth for which is the count relevant.
 */
public protocol PerftCache {
    func put(checksum: UInt64, depth: Int, count: UInt64)
    func get(checksum: UInt64, depth: Int) -> UInt64?
}

public extension ChessBoard {
    
    /**
     Simple PerfT in-memory cache
     */
    final class InMemoryPerftCache: PerftCache {
        
        public static let DEFAULT_CACHE_SIZE: UInt64        = 64 * 1024 * 1024
        public static let defaultInMemoryCache              = InMemoryPerftCache(cacheSize: InMemoryPerftCache.DEFAULT_CACHE_SIZE)

        /**
         Cache record
         */
        struct Record {
            let checksum:   UInt64
            let depth:      Int
            let count:      UInt64
        }
        
        /**
         Used for computing index keys. If cacheSize is too small, index keys will start repeating
         */
        private let cacheSize: UInt64
        
        /**
         On macos 10.13.1, Swift 4, dictionary is of the same performance as self managed fixed-size hash array
         Dictionary has advantage of no overflow errors.
         */
        var cache: [UInt64: Record]
        
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
        @inline(__always) func index(checksum: UInt64, depth: Int) -> UInt64 {
            return (cacheSize &- 1 &- UInt64(depth)) & checksum
        }
        
        public func put(checksum: UInt64, depth: Int, count: UInt64) {
            let index = self.index(checksum: checksum, depth: depth)
            cache[index] = Record(checksum: checksum, depth: depth, count: count)
        }
        
        public func get(checksum: UInt64, depth: Int) -> UInt64? {
            let index = self.index(checksum: checksum, depth: depth)
            
            if let record = cache[index], record.checksum == checksum && record.depth == depth {
                return record.count
            } else {
                return nil
            }
        }
    }
    
    
    /**
     Single thread perft minimax
     */
    public func perft1(depth: Int, cache: PerftCache = InMemoryPerftCache.defaultInMemoryCache) -> UInt64 {
        
        if(depth < 1) { return 1 }
        
        let zobristChecksum = ZobristChecksum.compute(board: self)
        
        if let cache = cache.get(checksum: zobristChecksum, depth: depth) {
            return cache
        }
        
        var count: UInt64 = 0
        
        let attacks = self.attacks(color: opponentColor)
        let isCheck = (attacks & self.pieces[sideToMove][Piece.king]) != 0
        
        for move in pseudoLegalMoves() {
            let sourceBitBoard = move.from.bitBoard
            let isKingMove = move.piece == Piece.king
            
            if isKingMove || isCheck || ((sourceBitBoard & attacks) != 0) || move.isEnpassant != 0{
                //need to validate move
                
                let nextBoard = makeMove(move: move)
                if !nextBoard.isOpponentsKingUnderCheck() {
                    if depth == 1 {
                        count = count &+ 1
                    } else {
                        count = count &+ nextBoard.perft1(depth: depth &- 1, cache: cache)
                    }
                }
            } else {
                if depth == 1 {
                    count = count &+ 1
                } else {
                    //do not need to validate legality of the move
                    let nextBoard = makeMove(move: move)
                    count = count &+ nextBoard.perft1(depth: depth &- 1, cache: cache)
                }
            }
        }
        
        cache.put(checksum: zobristChecksum, depth: depth, count: count)
        return count
    }
    
    /**
     Multi threaded perft
     */
    public func perftN(depth: Int) -> UInt64 {
        if depth <= 1 { return perft1(depth:depth) }
        
        var nextBoards = [ChessBoard]()
        
        //expand legal moves to boards
        for move in pseudoLegalMoves() {
            let nextBoard = makeMove(move: move)
            if !nextBoard.isOpponentsKingUnderCheck() {
                nextBoards.append(nextBoard)
            }
        }
        
        var totalCount: Int64 = 0
        DispatchQueue.concurrentPerform(iterations: nextBoards.count) {
            i in
            
            let board = nextBoards[i]
            let cache = InMemoryPerftCache(cacheSize: InMemoryPerftCache.DEFAULT_CACHE_SIZE)
            let count = board.perft1(depth: depth &- 1, cache: cache)
            
            OSAtomicAdd64(Int64(count), &totalCount)
        }
        
        return UInt64(totalCount)
    }
}
