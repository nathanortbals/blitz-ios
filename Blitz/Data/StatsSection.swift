//
//  StatsSection.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/16/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import Foundation

struct StatsSection: Codable {
    let name: String?
    let stats: [Stat]?
    
    func getFormattedName() -> String? {
        if let name = name {
            return (name as NSString)
                .replacingOccurrences(of: "([A-Z])", with: " $1", options:
                    .regularExpression, range: NSRange(location: 0, length: name.count))
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .capitalized
        }
        
        return nil
    }
}
