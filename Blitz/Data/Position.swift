//
//  Position.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/11/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import Foundation

enum Position: String, Codable {
    case QB =  "QB"
    case WR = "WR"
    case RB = "RB"
    case TE = "TE"
    case F = "F"
    case D = "D"
    
    func getPositionName() -> String {
        switch self {
        case .QB:
            return "Quarterback"
        case .WR:
            return "Wide Receiver"
        case .RB:
            return "Running Back"
        case .TE:
            return "Tight End"
        case .F:
            return "Flex"
        case .D:
            return "Defense"
        }
    }
}
