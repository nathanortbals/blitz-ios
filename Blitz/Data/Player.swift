//
//  Player.swift
//  Blitz
//
//  Created by Nathan Ortbals on 4/10/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import Foundation

struct Player: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let jerseyNumber: Int?
    
    func getFullName() -> String? {
        if let firstName = firstName, let lastName = lastName {
            return firstName + " " + lastName
        }
        
        return nil
    }
}
