//  Created by Dusan Saiko (dusan@saiko.cz)
//  Licensed under https://opensource.org/licenses/MIT

import Foundation
import SachistaCore

/**
 Performance tests executable
 */
private final class PerfT {

    let scriptName: String
    var depth: Int = 0
    var verifyCount: UInt64? = nil
    var multiThreaded: Bool = false
    var board: ChessBoard = ChessBoard.standard

    func showUsage() {
        print("""
        Usage: [-m] [-v=COUNT] DEPTH [FEN]
            
        Flags:
            -m: use multi threading
            -v: verify against given count
        
        Samples:
            ./\(scriptName) 6
            ./\(scriptName) -m 6
            ./\(scriptName) -v=89941194 5 "rnbq1k1r/pp1Pbppp/2p5/8/2B5/8/PPP1NnPP/RNBQK2R w KQ - 1 8"
        """)
    }
    
    init() {
        
        var args = CommandLine.arguments
        scriptName = URL(fileURLWithPath: args.removeFirst()).lastPathComponent

        var fen: String = ""
        var depth: Int? = nil
        
        while args.count > 0 {
            var arg = args.removeFirst()
            
            if arg == "-m" {
                multiThreaded = true
            } else if arg.starts(with: "-v=") {
                arg = String(arg.split(separator: "=").last!)
                if let count = Int64(arg) {
                    self.verifyCount = UInt64(count)
                } else {
                    print("Error: Invalid verify count: \(arg)")
                    showUsage()
                    exit(-1)
                }
            } else if depth == nil {
                depth = Int(arg)
            } else {
                fen += " \(arg)"
            }
        }
        
        if depth == nil {
            showUsage()
            exit(-1)
        }
        
        self.depth = depth!

        if fen == "" {
            fen = ChessBoard.standard.fenString
        }
        
        guard let chessBoard = ChessBoard(fenString: fen) else {
            print("Error: Invalid FEN parameter!")
            showUsage()
            exit(-1)
        }
        
        self.board = chessBoard
    }
    
    func run() {
        func format(timeInterval: TimeInterval) -> String {
            
            let ti = abs(Int(timeInterval))
            
            let ms = Int(abs(timeInterval).truncatingRemainder(dividingBy: 1) * 1000)
            
            let seconds = ti % 60
            let minutes = (ti / 60) % 60
            let hours = (ti / 3600)
            
            return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        }
        
        print("Running \(scriptName) \(multiThreaded ? "-m " : "")\(verifyCount != nil ? "-v=\(verifyCount!) " : "")\(depth) \"\(board.fenString)\" ...")
        
        let startTime = Date()
        
        let count: UInt64 = {
            if multiThreaded {
                return board.perftN(depth: depth)
            } else {
                return board.perft1(depth: depth)
            }
        }()
        
        let timeInterval = startTime.timeIntervalSinceNow
        
        print("""
        ---------
        Result:
        fen            : \(board.fenString)
        depth          : \(depth)
        count          : \(count)
        verification   : \(verifyCount == nil ? "-" : (verifyCount == count ? "PASSED" : "ERROR!"))
        multi threaded : \(multiThreaded)
        finished       : \(Date())
        time           : \(format(timeInterval: timeInterval))
        """)
    }
}

PerfT().run()

