//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public final class MoveGeneratorRook: MoveGenerator {

    //TODO: struct?
    final class Cache {
        var rankShift: [Int]
        var rankMask:  [BitBoard]
        var fileMask:  [BitBoard]
        var fileMagic: [BitBoard]
        var rankMoves: [[BitBoard]]
        var fileMoves: [[BitBoard]]
        
        init() {
            var rankShift = [Int](repeating: 0, count: 64)
            var rankMask  = [BitBoard](repeating: 0, count: 64)
            var fileMask  = [BitBoard](repeating: 0, count: 64)
            var fileMagic = [BitBoard](repeating: 0, count: 64)
            var rankMoves = [[BitBoard]](repeating: [BitBoard](repeating: .empty, count: 64), count: 64)
            var fileMoves = [[BitBoard]](repeating: [BitBoard](repeating: .empty, count: 64), count: 64)
            
            let MAGIC_FILE: [BitBoard] = [
                0x8040201008040200,
                0x4020100804020100,
                0x2010080402010080,
                0x1008040201008040,
                0x0804020100804020,
                0x0402010080402010,
                0x0201008040201008,
                0x0100804020100804
            ]
            
            let fileA6: BitBoard = .a2 | .a3 | .a4 | .a5 | .a6 | .a7
            
            for i in 0 ..< 64 {
                let rankIndex = BitBoard.Index(rawValue: i)!.rankIndex
                let fileIndex = BitBoard.Index(rawValue: i)!.fileIndex
                
                //get 6-bit mask for a rank
                rankMask[i] = BitBoard(126) << (rankIndex << 3)
                
                //compute needed rank shift
                rankShift[i] = (rankIndex << 3) + 1
                
                //get 6-bit mask for a file
                fileMask[i] = fileA6 << fileIndex
                
                //index magic number directly fo field
                fileMagic[i] = MAGIC_FILE[fileIndex]
            }
            
            //precompute rank moves
            //for all pieces
            for i in 0 ..< 64 {
                let rankIndex = BitBoard.Index(rawValue: i)!.rankIndex
                
                //for all occupancy states
                for n in 0 ..< 64 {
                    //reconstruct occupancy state
                    let board: BitBoard = BitBoard(n).shift(dx: 1, dy: rankIndex)
                    
                    //generate available moves
                    var moves: BitBoard = .empty
                    
                    //set piece in Ith position
                    var piece = BitBoard.Index(rawValue: i)!.bitBoard
                    
                    //move in one direction
                    while piece != .empty {
                        piece = piece.oneWest
                        
                        moves |= piece
                        
                        //end when there is another piece on the board (either color, own color will have to be stripped out)
                        if (piece & board) != 0 {
                            break
                        }
                    }
                    
                    //set piece back in Ith position
                    piece = BitBoard.Index(rawValue: i)!.bitBoard
                    
                    //move in other direction
                    while piece != .empty {
                        piece = piece.oneEast
                        moves |= piece
                        
                        //end when there is another piece on the board (either color, own color will have to be stripped out)
                        if (piece & board) != 0 {
                            break
                        }
                    }
                    
                    //remember the moves
                    rankMoves[i][n] = moves
                }
            }
            
            
            //precompute file moves
            //for all pieces
            for i in 0 ..< 64 {
                let fileIndex = BitBoard.Index(rawValue: i)!.fileIndex
                
                //for all occupancy states
                for n in 0 ..< 64 {
                    
                    //reconstuct the occupancy into file
                    let board: BitBoard = BitBoard(n).shift(dx: 1, dy: 0).mirrorHorizontal.flipA1H8.shift(dx: fileIndex, dy: 0)
                    
                    //generate available moves
                    var moves: BitBoard = .empty
                    
                    //set piece back in Ith position
                    var piece = BitBoard.Index(rawValue: i)!.bitBoard
                    
                    //move piece in one direction
                    while piece != .empty {
                        piece = piece.oneNorth
                        
                        moves |= piece
                        
                        //end when there is another piece on the board (either color, own color will have to be stripped out)
                        if (piece & board) != 0 {
                            break
                        }
                    }
                    
                    //set piece back to original Ith index
                    piece = BitBoard.Index(rawValue: i)!.bitBoard
                    
                    //move piece in other direction
                    while piece != .empty {
                        piece = piece.oneSouth
                        
                        moves |= piece
                        
                        //end when there is another piece on the board (either color, own color will have to be stripped out)
                        if (piece & board) != 0 {
                            break
                        }
                    }
                    
                    //remember file attacks
                    fileMoves[i][n] = moves
                }
            }
            
            self.rankShift = rankShift
            self.rankMask = rankMask
            self.fileMask = fileMask
            self.fileMagic = fileMagic
            self.rankMoves = rankMoves
            self.fileMoves = fileMoves
        }
    }
   
    static let cache = Cache()

    //TODO PERFORMANCE: try experimenting with inline?
    func pieceMoves(sourceIndex: Int, allPieces: BitBoard) -> BitBoard {
        //use magic multipliers to get occupancy state index
        let stateIndexRank = Int((allPieces & MoveGeneratorRook.cache.rankMask[sourceIndex]) >> MoveGeneratorRook.cache.rankShift[sourceIndex])
        let stateIndexFile = Int(((allPieces & MoveGeneratorRook.cache.fileMask[sourceIndex]) &* MoveGeneratorRook.cache.fileMagic[sourceIndex]) >> 57) //TODO: MAGIC 57
        
        //get possible attacks for field / occupancy state index
        return MoveGeneratorRook.cache.rankMoves[sourceIndex][stateIndexRank] | MoveGeneratorRook.cache.fileMoves[sourceIndex][stateIndexFile]
    }
    
    func attacks(board: ChessBoard, color: ChessBoard.Color) -> BitBoard {
        var pieces = board.pieces[color][ChessBoard.Piece.rook] | board.pieces[color][ChessBoard.Piece.queen]
        var attacks: BitBoard = .empty
        
        //for all rooks
        while pieces != .empty {
            attacks |= pieceMoves(sourceIndex: pieces.bitPop().rawValue, allPieces: board.allPiecesBoard)
        }
        
        return attacks
    }
    
    func moves(board: ChessBoard) -> [Move] {
        var result  = [Move]()
        
        for piece in [ChessBoard.Piece.rook, ChessBoard.Piece.queen] {
            var pieces = board.pieces[board.sideToMove][piece]

            //for all rooks
            while pieces != .empty {
                //get next rook
                let sourceIndex = pieces.bitPop()
                var moves: BitBoard = pieceMoves(sourceIndex: sourceIndex.rawValue, allPieces: board.allPiecesBoard) & board.emptyOrOpponentPiecesBoard
                
                //for all moves
                while moves != .empty {
                    let targetIndex = moves.bitPop()
                    let isCapture = (targetIndex.bitBoard & board.opponentPiecesBoard) != 0
                    result.append(Move(piece: piece, from: sourceIndex, to: targetIndex, isCapture: isCapture, isEnpassant: false, promotionPiece: nil))
                }
            }
        }
        
        return result
    }
}



