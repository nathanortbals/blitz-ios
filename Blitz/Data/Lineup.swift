//
//  Lineup.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import Foundation

struct Lineup: Codable {
    let qb: DfsEntry
    let rb1: DfsEntry
    let rb2: DfsEntry
    let wr1: DfsEntry
    let wr2: DfsEntry
    let wr3: DfsEntry
    let te: DfsEntry
    let f: DfsEntry
    let d: DfsEntry
    
    static let lineupCount = 9
    
    func getDfsEntryFromIndex(index: Int) -> DfsEntry? {
        switch(index) {
        case 0:
            return qb
        case 1:
            return rb1
        case 2:
            return rb2
        case 3:
            return wr1
        case 4:
            return wr2
        case 5:
            return wr3
        case 6:
            return te
        case 7:
            return f
        case 8:
            return d
        default:
            return nil
        }
    }
    
    static func getPositionNameFromIndex(index: Int) -> String? {
        switch(index) {
        case 0:
            return "Quarterback"
        case 1:
            return "Running Back 1"
        case 2:
            return "Running Back 2"
        case 3:
            return "Wide Receiver 1"
        case 4:
            return "Wide Receiver 2"
        case 5:
            return "Wide Receiver 3"
        case 6:
            return "Tight End"
        case 7:
            return "Flex"
        case 8:
            return "Defense"
        default:
            return nil
        }
    }
    
    static func getPositionFromIndex(index: Int) -> Position? {
        switch(index) {
        case 0:
            return .QB
        case 1:
            return .RB
        case 2:
            return .RB
        case 3:
            return .WR
        case 4:
            return .WR
        case 5:
            return .WR
        case 6:
            return .TE
        case 7:
            return .F
        case 8:
            return .D
        default:
            return nil
        }
    }
}
