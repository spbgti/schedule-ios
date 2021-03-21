//
//  ScheduleWeek.swift
//  schedule
//
//  Created by Vladislav Glumov on 21.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

enum ScheduleWeek: Int, CaseIterable {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
}

extension ScheduleWeek {
    var name: String {
        switch self {
        case .monday:
            return "Понедельник"
        
        case .tuesday:
            return "Вторник"
            
        case .wednesday:
            return "Среда"
            
        case .thursday:
            return "Четверг"
            
        case .friday:
            return "Пятница"
            
        case .saturday:
            return "Суббота"
            
        case .sunday:
            return "Воскресенье"
        }
    }
}
