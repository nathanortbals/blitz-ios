//
//  DfsEntry.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import Foundation

struct DfsEntry: Codable {
    let player: Player?
    let team: Team?
    let game: Game?
    let dfsSourceId: Int?
    let salary: Int?
    let fantasyPoints: Float?
}
