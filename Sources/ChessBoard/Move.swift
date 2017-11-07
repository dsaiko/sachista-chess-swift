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

        let halfMoveClock = self.halfMoveClock + 1
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
        
        zobristChecksum ^= ZobristChecksum.rndPieces[move.piece.zobristNumericIndex][sourceIndex.rawValue] ^ ZobristChecksum.rndPieces[move.piece.zobristNumericIndex][targetIndex.rawValue]

//        if(piece ==  Rook) {
//            if(board.castling[board.nextMove]) {
//                if(sourceIndex == BoardIndex::A1 && board.nextMove == White)
//                board.removeCastling(board.nextMove, QueenSide);
//                if(sourceIndex == BoardIndex::H1 && board.nextMove == White)
//                board.removeCastling(board.nextMove, KingSide);
//                if(sourceIndex == BoardIndex::A8 && board.nextMove == Black)
//                board.removeCastling(board.nextMove, QueenSide);
//                if(sourceIndex == BoardIndex::H8 && board.nextMove == Black)
//                board.removeCastling(board.nextMove, KingSide);
//            }
//        } else if(piece == King) {
//            board.castling[board.nextMove] = None;
//            if (sourceIndex == BoardIndex::E1 && board.nextMove == White) {
//                //castling
//                if (targetIndex == BoardIndex::C1) {
//                    pieces[ Rook] ^= BitMask::A1 | BitMask::D1;
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][ Rook][BoardIndex::A1] ^ ChessBoard::zobrist.Z_PIECES[board.nextMove][ Rook][BoardIndex::D1];
//                } else if(targetIndex == BoardIndex::G1) {
//                    pieces[ Rook] ^= BitMask::H1 | BitMask::F1;
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][ Rook][BoardIndex::H1] ^ ChessBoard::zobrist.Z_PIECES[board.nextMove][ Rook][BoardIndex::F1];
//                }
//            }
//            if (sourceIndex == BoardIndex::E8 && board.nextMove == Black) {
//                //castling
//                if (targetIndex == BoardIndex::C8) {
//                    pieces[ Rook] ^= BitMask::A8 | BitMask::D8;
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][ Rook][BoardIndex::A8] ^ ChessBoard::zobrist.Z_PIECES[board.nextMove][ Rook][BoardIndex::D8];
//                } else if(targetIndex == BoardIndex::G8) {
//                    pieces[ Rook] ^= BitMask::H8 | BitMask::F8;
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][ Rook][BoardIndex::H8] ^ ChessBoard::zobrist.Z_PIECES[board.nextMove][ Rook][BoardIndex::F8];
//                }
//            }
//        } else if(piece ==  Pawn) {
//            board.halfMoveClock = 0;
//
//            int step = targetIndex - sourceIndex;
//            if (abs(step) > 10) {
//                board.enPassantTargetIndex = sourceIndex + (board.nextMove == White ? 8 : -8);
//            } else if (promotionPiece != Piece::NoPiece) {
//                pieces[Pawn] ^= target;
//                board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][Pawn][targetIndex];
//                if (promotionPiece == Queen) {
//                    pieces[Queen] |= target;
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][Queen][targetIndex];
//                } else if (promotionPiece ==  Rook) {
//                    pieces[Rook] |= target;
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][Rook][targetIndex];
//                } else if (promotionPiece ==  Bishop) {
//                    pieces[Bishop] |= target;
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][Bishop][targetIndex];
//                } else if (promotionPiece ==  Knight) {
//                    pieces[Knight] |= target;
//                    board.zobristKey ^= ChessBoard::zobrist.Z_PIECES[board.nextMove][Knight][targetIndex];
//                }
//            }
//        }
//
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

