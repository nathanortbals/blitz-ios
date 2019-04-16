//
//  Stats.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/16/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import Foundation

struct Stats: Codable {
    let gamesPlayed: Int?
    let sections: [StatsSection]?
}
