//
//  Reminder.swift
//  schedule
//
//  Created by vladislav on 05.10.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

struct Reminder: Codable {
    var name: String
    var description: String?
    var hour: String
    var minute: String
    var isRepeate: Bool
    var isActive: Bool
}
