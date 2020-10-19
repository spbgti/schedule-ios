//
//  Group.swift
//  schedule
//
//  Created by vlad on 17.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Group: Codable {
    let groupId: Int
    let number: String
    
    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case number
    }
}
