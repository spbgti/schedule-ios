//
//  ScheduleParity.swift
//  schedule
//
//  Created by Vladislav Glumov on 21.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

enum ScheduleParity: String, CaseIterable {
    case odd = "1"
    case even = "2"
}

extension ScheduleParity {
    var name: String {
        switch self {
        case .odd:
            return "Нечетная"
        
        case .even:
            return "Четная"
        }
    }
}
