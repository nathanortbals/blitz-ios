//
//  Game.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import Foundation

struct Game: Codable {
    let id: Int?
    let week: Int?
    let startTime: String?
    let awayTeamAbbreviation: String?
    let homeTeamAbbreviation: String?
}
