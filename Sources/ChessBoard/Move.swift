//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation

public struct Move: CustomStringConvertible {
    let piece:          Piece
    
    let from:           BitBoard.Index
    let to:             BitBoard.Index
    
    let isCapture:      Bool
    let isEnpassant:    Bool
    let promotionPiece: Piece?

    public init(piece: Piece, from: BitBoard.Index, to: BitBoard.Index, isCapture: Bool = false, isEnpassant: Bool = false, promotionPiece: Piece? = nil) {
        self.piece          = piece
        self.from           = from
        self.to             = to
        self.isCapture      = isCapture
        self.isEnpassant    = isEnpassant
        self.promotionPiece = promotionPiece
    }
    
    public var description: String {
        return "\(from)\(isCapture ? "x" : "")\(to)\((promotionPiece?.description ?? "").lowercased())"
    }
}

protocol MoveGenerator {
    
    func attacks(board: ChessBoard, color: Piece.Color) -> BitBoard
    
    //TODO PERFORMANCE: Move array??
    func moves(board: ChessBoard) -> [Move]
}

extension ChessBoard {
    
    //TODO PERFORMANCE: try mutable chessboard
    //TODO PERFORMANCE: undo move
    //TODO PERFORMANCE: try re compute zobrist every time
    //TODO PERFORMANCE: reseting castling options in place?
    func makeMove(move: Move) -> ChessBoard {

        let sourceIndex = move.from
        let targetIndex = move.to
        let sourceBitBoard = sourceIndex.bitBoard
        let targetBitBoard = targetIndex.bitBoard

        var halfMoveClock = self.halfMoveClock + 1
        var zobristChecksum = self.zobristChecksum
        var enPassantTarget = self.enPassantTarget

        var isWhiteKingSideCastlingAvailable    = self.whiteCastlingOptions.isKingSideCastlingAvailable
        var isWhiteQueenSideCastlingAvailable   = self.whiteCastlingOptions.isQueenSideCastlingAvailable
        var isBlackKingSideCastlingAvailable    = self.blackCastlingOptions.isKingSideCastlingAvailable
        var isBlackQueenSideCastlingAvailable   = self.blackCastlingOptions.isQueenSideCastlingAvailable
        
        var fullMoveNumber                      = self.fullMoveNumber
        var nextMove                            = self.nextMove
        
        var whiteKing                           = self.whitePieces.king
        var whiteQueen                          = self.whitePieces.queen
        var whiteBishop                         = self.whitePieces.bishop
        var whiteKnight                         = self.whitePieces.knight
        var whiteRook                           = self.whitePieces.rook
        var whitePawn                           = self.whitePieces.pawn

        var blackKing                           = self.blackPieces.king
        var blackQueen                          = self.blackPieces.queen
        var blackBishop                         = self.blackPieces.bishop
        var blackKnight                         = self.blackPieces.knight
        var blackRook                           = self.blackPieces.rook
        var blackPawn                           = self.blackPieces.pawn

        //reset enPassant
        if let target = enPassantTarget {
            zobristChecksum ^= ZobristChecksum.rndEnPassantFile[target.fileIndex]
            enPassantTarget = nil
        }

        //remove castling options, will set them at the end
        //TODO: move inline? + castling
        if isWhiteKingSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingWhiteKing
        }
        if isWhiteQueenSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingWhiteQueen
        }
        if isBlackKingSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingBlackKing
        }
        if isBlackQueenSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingBlackQueen
        }
        
        //TODO PERFORMANCE: try to use the pieces map
        switch move.piece {
            case .whiteKing:     whiteKing          ^= sourceBitBoard | targetBitBoard
            case .whiteQueen:    whiteQueen         ^= sourceBitBoard | targetBitBoard
            case .whiteBishop:   whiteBishop        ^= sourceBitBoard | targetBitBoard
            case .whiteKnight:   whiteKnight        ^= sourceBitBoard | targetBitBoard
            case .whiteRook:     whiteRook          ^= sourceBitBoard | targetBitBoard
            case .whitePawn:     whitePawn          ^= sourceBitBoard | targetBitBoard
            
            case .blackKing:     blackKing          ^= sourceBitBoard | targetBitBoard
            case .blackQueen:    blackQueen         ^= sourceBitBoard | targetBitBoard
            case .blackBishop:   blackBishop        ^= sourceBitBoard | targetBitBoard
            case .blackKnight:   blackKing          ^= sourceBitBoard | targetBitBoard
            case .blackRook:     blackRook          ^= sourceBitBoard | targetBitBoard
            case .blackPawn:     blackPawn          ^= sourceBitBoard | targetBitBoard
        }
        
        zobristChecksum ^= ZobristChecksum.rndPieces[move.piece.rawValue][sourceIndex.rawValue] ^ ZobristChecksum.rndPieces[move.piece.rawValue][targetIndex.rawValue]

        if move.piece == .whiteRook {
            if sourceIndex == .a1 {
                isWhiteQueenSideCastlingAvailable = false
            } else if sourceIndex == .h8 {
                isWhiteKingSideCastlingAvailable = false
            }
        } else if move.piece == .blackRook {
            if sourceIndex == .a8 {
                isBlackQueenSideCastlingAvailable = false
            } else if sourceIndex == .h8 {
                isBlackKingSideCastlingAvailable = false
            }
        } else if move.piece == .whiteKing {
            isWhiteQueenSideCastlingAvailable = false
            isWhiteKingSideCastlingAvailable = false
            
            if sourceIndex == .e1 {
                //handle castling
                if targetIndex == .c1 {
                    whiteRook ^= BitBoard.a1 | BitBoard.d1
                    zobristChecksum ^= ZobristChecksum.rndPieces[move.piece.rawValue][BitBoard.Index.a1.rawValue] ^ ZobristChecksum.rndPieces[move.piece.rawValue][BitBoard.Index.d1.rawValue]
                } else if targetIndex == .g1 {
                    whiteRook ^= BitBoard.h1 | BitBoard.f1
                    zobristChecksum ^= ZobristChecksum.rndPieces[move.piece.rawValue][BitBoard.Index.h1.rawValue] ^ ZobristChecksum.rndPieces[move.piece.rawValue][BitBoard.Index.f1.rawValue]
                }
            }
        } else if move.piece == .blackKing {
            isBlackQueenSideCastlingAvailable = false
            isBlackKingSideCastlingAvailable = false
            
            if sourceIndex == .e8 {
                //handle castling
                if targetIndex == .c8 {
                    whiteRook ^= BitBoard.a8 | BitBoard.d8
                    zobristChecksum ^= ZobristChecksum.rndPieces[move.piece.rawValue][BitBoard.Index.a8.rawValue] ^ ZobristChecksum.rndPieces[move.piece.rawValue][BitBoard.Index.d8.rawValue]
                } else if targetIndex == .g8 {
                    whiteRook ^= BitBoard.h8 | BitBoard.f8
                    zobristChecksum ^= ZobristChecksum.rndPieces[move.piece.rawValue][BitBoard.Index.h8.rawValue] ^ ZobristChecksum.rndPieces[move.piece.rawValue][BitBoard.Index.f8.rawValue]
                }
            }
        } else if move.piece == .whitePawn {
            halfMoveClock = 0

            //initial pawn double move
            if abs(targetIndex.rawValue - sourceIndex.rawValue) > 10 {
                enPassantTarget = BitBoard.Index(rawValue: sourceIndex.rawValue + 8)!
            } else if let promotionPiece = move.promotionPiece {
                whitePawn ^= targetBitBoard //TODO: OR shoutld be same as XOR here
                zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whitePawn.rawValue][targetIndex.rawValue]
                
                //TODO: SIMPLIFY!
                if promotionPiece == .whiteQueen {
                    whiteQueen |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteQueen.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .whiteBishop {
                    whiteBishop |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteBishop.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .whiteKnight {
                    whiteKnight |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteKnight.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .whiteRook {
                    whiteRook |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.whiteRook.rawValue][targetIndex.rawValue]
                }
            }
        } else if move.piece == .blackPawn {
            halfMoveClock = 0
            
            //initial pawn double move
            if abs(targetIndex.rawValue - sourceIndex.rawValue) > 10 {
                enPassantTarget = BitBoard.Index(rawValue: sourceIndex.rawValue + -8)!
            } else if let promotionPiece = move.promotionPiece {
                blackPawn ^= targetBitBoard //TODO: OR shoutld be same as XOR here
                zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackPawn.rawValue][targetIndex.rawValue]
                
                //TODO: SIMPLIFY!
                if promotionPiece == .blackQueen {
                    blackQueen |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackQueen.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .blackBishop {
                    blackBishop |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackBishop.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .blackKnight {
                    blackKnight |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackKnight.rawValue][targetIndex.rawValue]
                } else if promotionPiece == .blackRook {
                    blackRook |= targetBitBoard
                    zobristChecksum ^= ZobristChecksum.rndPieces[Piece.blackRook.rawValue][targetIndex.rawValue]
                }
            }
        }
        
//        //reset halfmoveClock if piece was captured
//        if (isCapture) {
//            board.halfMoveClock = 0;
//
//            //check capture
//            if (isEnPassant) {
//                if(board.nextMove == White) {
//                    board.pieces[opponentColor][Pawn] ^= BitBoard::oneSouth(target);
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[opponentColor][Pawn][targetIndex - 8];
//                } else {
//                    board.pieces[opponentColor][Pawn] ^= BitBoard::oneNorth(target);
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[opponentColor][Pawn][targetIndex + 8];
//                }
//            } else if (board.pieces[opponentColor][Bishop] & target) {
//                board.pieces[opponentColor][Bishop] ^= target;
//                board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[opponentColor][Bishop][targetIndex];
//            } else if (board.pieces[opponentColor][Knight] & target) {
//                board.pieces[opponentColor][Knight] ^= target;
//                board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[opponentColor][Knight][targetIndex];
//            } else if (board.pieces[opponentColor][Pawn] & target) {
//                board.pieces[opponentColor][Pawn] ^= target;
//                board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[opponentColor][Pawn][targetIndex];
//            } else if (board.pieces[opponentColor][Queen] & target) {
//                board.pieces[opponentColor][Queen] ^= target;
//                board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[opponentColor][Queen][targetIndex];
//            } else if (board.pieces[opponentColor][ Rook] & target) {
//                board.pieces[opponentColor][Rook] ^= target;
//                board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[opponentColor][Rook][targetIndex];
//
//                if(board.nextMove == White) {
//                    if (targetIndex == BoardIndex::A8) {
//                        board.removeCastling(Black, QueenSide);
//                    } else if (targetIndex == BoardIndex::H8) {
//                        board.removeCastling(Black, KingSide);
//                    }
//                } else {
//                    if (targetIndex == BoardIndex::A1) {
//                        board.removeCastling(White, QueenSide);
//                    } else if (targetIndex == BoardIndex::H1) {
//                        board.removeCastling(White, KingSide);
//                    }
//                }
//            }
//        }
//
        if nextMove == .black {
            fullMoveNumber += 1
        }

        nextMove = self.opponentColor
        zobristChecksum ^= ZobristChecksum.rndBlackSide //switch the side
        
        //set enPassant
        if let target = enPassantTarget {
            zobristChecksum ^= ZobristChecksum.rndEnPassantFile[target.fileIndex]
        }
        
        //set castling options
        if isWhiteKingSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingWhiteKing
        }
        if isWhiteQueenSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingWhiteQueen
        }
        if isBlackKingSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingBlackKing
        }
        if isBlackQueenSideCastlingAvailable {
            zobristChecksum ^= ZobristChecksum.rndCastlingBlackQueen
        }
        
        
        let whitePieces = Pieces(
            king:   whiteKing,
            queen:  whiteQueen,
            bishop: whiteBishop,
            knight: whiteKnight,
            rook:   whiteRook,
            pawn:   whitePawn
        )
        
        let blackPieces = Pieces(
            king:   blackKing,
            queen:  blackQueen,
            bishop: blackBishop,
            knight: blackKnight,
            rook:   blackRook,
            pawn:   blackPawn
        )
        
        return ChessBoard(
            nextMove:               nextMove,
            whitePieces:            whitePieces,
            blackPieces:            blackPieces,
            whiteCastlingOptions:   CastlingOptions(isKingSideCastlingAvailable: isWhiteKingSideCastlingAvailable, isQueenSideCastlingAvailable: isWhiteQueenSideCastlingAvailable),
            blackCastlingOptions:   CastlingOptions(isKingSideCastlingAvailable: isBlackKingSideCastlingAvailable, isQueenSideCastlingAvailable: isBlackQueenSideCastlingAvailable),
            enPassantTarget:        enPassantTarget,
            halfMoveClock:          halfMoveClock,
            fullMoveNumber:         fullMoveNumber,
            zobristChecksum:        zobristChecksum
        )
    }
}

