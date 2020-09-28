//
//  Room.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Room: Codable {
    let roomId: Int
    let name: String
    let locationId: String
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case name
        case locationId = "location_id"
    }
}
