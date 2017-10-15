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


