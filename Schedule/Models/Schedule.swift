//
//  Schedule.swift
//  schedule
//
//  Created by vlad on 17.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct Schedule: Codable {
    let scheduleId: Int
    let groupId: Int
    let year: String
    let semester: String
    let exercises: [Exercise]
}
