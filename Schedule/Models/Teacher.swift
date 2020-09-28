//
//  Teacher.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Teacher: Codable {
    let teacherId: Int
    let name: String
    let rank: String
    let position: String
    
    enum CodingKeys: String, CodingKey {
        case teacherId = "teacher_id"
        case name
        case rank
        case position
    }
}
