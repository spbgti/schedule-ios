//
//  ScheduleParity.swift
//  schedule
//
//  Created by Vladislav Glumov on 21.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

enum ScheduleParity: CaseIterable {
    case odd
    case even
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
