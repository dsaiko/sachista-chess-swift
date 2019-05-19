//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

struct MoveGeneratorBishop: MoveGenerator {
    
    struct Cache {
        let a1H8Mask: [BitBoard]
        let a1H8Magic: [BitBoard]
        let a8H1Mask: [BitBoard]
        let a8H1Magic: [BitBoard]
        
        let a1H8Moves: [[BitBoard]]
        let a8H1Moves: [[BitBoard]]
        
        init() {
            let MAGIC_A8H1: [BitBoard] = [
                0x0,
                0x0,
                0x0101010101010100,
                0x0101010101010100,
                0x0101010101010100,
                0x0101010101010100,
                0x0101010101010100,
                0x0101010101010100,
                0x0080808080808080,
                0x0040404040404040,
                0x0020202020202020,
                0x0010101010101010,
                0x0008080808080808,
                0x0,
                0x0
            ]
            
            let MAGIC_A1H8: [BitBoard] = [
                0x0,
                0x0,
                0x0101010101010100,
                0x0101010101010100,
                0x0101010101010100,
                0x0101010101010100,
                0x0101010101010100,
                0x0101010101010100,
                0x8080808080808000,
                0x4040404040400000,
                0x2020202020000000,
                0x1010101000000000,
                0x0808080000000000,
                0x0,
                0x0
            ]

            var a1H8Index = [Int](repeating:0, count: 64)
            var a8H1Index = [Int](repeating:0, count: 64)
            
            var a1H8Mask = [BitBoard](repeating: 0, count: 64)
            var a1H8Magic = [BitBoard](repeating: 0, count: 64)
            var a8H1Mask = [BitBoard](repeating: 0, count: 64)
            var a8H1Magic = [BitBoard](repeating: 0, count: 64)

            var a1H8Moves = [[BitBoard]](repeating: [BitBoard](repeating: .empty, count: 64), count: 64)
            var a8H1Moves = [[BitBoard]](repeating: [BitBoard](repeating: .empty, count: 64), count: 64)

            //for all fields
            for i in 0 ..< 64 {
                let rankIndex = BitBoard.Index(rawValue: i)!.rankIndex
                let fileIndex = BitBoard.Index(rawValue: i)!.fileIndex
                
                //compute index of diagonal for the field
                a8H1Index[i] = fileIndex &+ rankIndex % 8
                a1H8Index[i] = fileIndex &+ 7 &- rankIndex % 8
                
                //compute 6-bit diagonal for the field
                a8H1Mask[i] = BitBoard.a8h1[a8H1Index[i]] & ~BitBoard.frame
                a1H8Mask[i] = BitBoard.a1h8[a1H8Index[i]] & ~BitBoard.frame
                
                //index magic multiplier for the field
                a8H1Magic[i] = MAGIC_A8H1[a8H1Index[i]]
                a1H8Magic[i] = MAGIC_A1H8[a1H8Index[i]]
            }
            
            //precompute A1H8 moves
            // i is field index
            // n is 6 bit configuration
            
            //for all fields
            for i in 0 ..< 64 {
                //for all possible diagonal states
                for n in 0 ..< 64 {
                    
                    //get the diagonal
                    var diagonal = BitBoard.a1h8[a1H8Index[i]]
                    
                    //reconstruct the state (number) into the diagonal
                    
                    //get the left/bottom bit - start of diagonal
                    while diagonal.oneSouthWest != .empty {
                        diagonal = diagonal.oneSouthWest
                    }
                    
                    var board: BitBoard = .empty
                    
                    var m = n
                    //traverse diagonal and set bits according to N
                    while diagonal != .empty {
                        //shift up by one
                        diagonal = diagonal.oneNorthEast
                        if (m & 1) != 0 {
                            board |= diagonal
                        }
                        m &>>= 1
                    }
                    
                    //make it 6-bit only
                    board &= ~BitBoard.frame
                    
                    //compute possible moves
                    var moves: BitBoard = .empty
                    
                    //set piece to Ith index
                    var piece = BitBoard.Index(rawValue: i)!.bitBoard
                    
                    //move in one direction
                    while piece != .empty {
                        piece = piece.oneNorthEast
                        moves |= piece
                        
                        //end when there is another piece (either color, own color will have to be stripped out)
                        if (piece & board) != 0 {
                            piece = .empty
                        }
                    }
                    
                    //set piece back to Ith index
                    piece = BitBoard.Index(rawValue: i)!.bitBoard
                    
                    //move in the other direction
                    while piece != .empty {
                        piece = piece.oneSouthWest
                        moves |= piece
                        
                        //end when there is another piece (either color, own color will have to be stripped out)
                        if (piece & board) != 0 {
                            piece = .empty
                        }
                    }
                    
                    //remember the moves for Ith field within Nth occupancy state
                    a1H8Moves[i][n] = moves
                }
            }
            
            //precompute A8H1 moves
            // i is field index
            // n is 6 bit configuration
            //for all fields
            for i in 0 ..< 64 {
                //for all possible diagonal states
                for n in 0 ..< 64 {
                    
                    //get the diagonal
                    var diagonal = BitBoard.a8h1[a8H1Index[i]]
                    
                    //get the left/top bit - start of the diagonal
                    while (diagonal.oneNorthWest) != .empty {
                        diagonal = diagonal.oneNorthWest
                    }
                    
                    //traverse diagonal and set bits according to N
                    var board: BitBoard = .empty
                    
                    var m = n
                    while diagonal != .empty {
                        //shift down by one
                        diagonal = diagonal.oneSouthEast
                        if (m & 1) != 0 {
                            board |= diagonal
                        }
                        m &>>= 1
                    }
                    
                    //make it 6-bit only
                    board &= ~BitBoard.frame
                    
                    //pre-compute moves
                    var moves: BitBoard = .empty
                    
                    //set the piece to Ith position
                    var piece = BitBoard.Index(rawValue: i)!.bitBoard
                    
                    //move one direction
                    while (piece) != .empty {
                        piece = piece.oneNorthWest
                        moves |= piece
                        //end when there is another piece (either color, own color will have to be stripped out)
                        if (piece & board) != 0 {
                            piece = .empty
                        }
                    }
                    
                    //set the piece back to Ith position
                    piece = BitBoard.Index(rawValue: i)!.bitBoard
                    //move the other direction
                    while (piece) != .empty {
                        piece = piece.oneSouthEast
                        moves |= piece
                        //end when there is another piece (either color, own color will have to be stripped out)
                        if (piece & board) != 0 {
                            piece = .empty
                        }
                    }
                    a8H1Moves[i][n] = moves
                }
            }
            
            self.a1H8Mask = a1H8Mask
            self.a1H8Magic = a1H8Magic
            self.a8H1Mask = a8H1Mask
            self.a8H1Magic = a8H1Magic
            
            self.a1H8Moves = a1H8Moves
            self.a8H1Moves = a8H1Moves
        }
    }
    
    static let cache = Cache()
    
    //TODO PERFORMANCE: try experimenting with inline?
    func pieceMoves(sourceIndex: Int, allPieces: BitBoard) -> BitBoard {
        
        let stateIndexA8H1 = Int(((allPieces & MoveGeneratorBishop.cache.a8H1Mask[sourceIndex]) &* MoveGeneratorBishop.cache.a8H1Magic[sourceIndex]) &>> 57)
        let stateIndexA1H8 = Int(((allPieces & MoveGeneratorBishop.cache.a1H8Mask[sourceIndex]) &* MoveGeneratorBishop.cache.a1H8Magic[sourceIndex]) &>> 57)
        
        //add attacks
        return MoveGeneratorBishop.cache.a8H1Moves[sourceIndex][stateIndexA8H1] | MoveGeneratorBishop.cache.a1H8Moves[sourceIndex][stateIndexA1H8]
    }
    
    func attacks(board: ChessBoard, color: ChessBoard.Color) -> BitBoard {
        let pieces = board.piecesBy(color: color)
        var bishops = pieces.bishop | pieces.queen
        var attacks: BitBoard = .empty
        
        //for all bishops
        while bishops != .empty {
            attacks |= pieceMoves(sourceIndex: bishops.bitPop().rawValue, allPieces: board.allPiecesBoard)
        }
        
        return attacks
    }
    
    func moves(board: ChessBoard, result: inout [Move]) {
        
        let pieces = board.piecesBy(color: board.sideToMove)
        
        for bishops in [(ChessBoard.Piece.bishop, pieces.bishop), (ChessBoard.Piece.queen, pieces.queen)] {
            
            var p = bishops.1
            
            while p != .empty {
                
                //get next bishop
                let sourceIndex = p.bitPop()
                var moves: BitBoard = pieceMoves(sourceIndex: sourceIndex.rawValue, allPieces: board.allPiecesBoard) & board.emptyOrOpponentPiecesBoard
                
                //for all moves
                while moves != .empty {
                    let targetIndex = moves.bitPop()
                    result.append(Move(piece: bishops.0, from: sourceIndex, to: targetIndex))
                }
            }
        }
    }
    
}
