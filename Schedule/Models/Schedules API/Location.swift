//
//  Location.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Location: Codable {
    let locationId: Int
    let name: String
    let geoPosition: String?
    
    enum CodingKeys: String, CodingKey {
        case locationId = "location_id"
        case name
        case geoPosition = "geo_position"
    }
}
