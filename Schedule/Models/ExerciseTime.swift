//
//  ExerciseTime.swift
//  schedule
//
//  Created by Vladislav Glumov on 14.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

struct ExerciseTime: Decodable {
    let id: Int
    let start: String
    let end: String
}
