//
//  AcademicSemester.swift
//  schedule
//
//  Created by Vladislav Glumov on 21.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

enum ScheduleSemester: String {
    case spring = "1"
    case fall = "2"
}

extension ScheduleSemester {
    static func semester(_ date: Date) -> Self? {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        
        switch month {
        case (1...6):
            return .spring
            
        case (9...12):
            return .fall
            
        default:
            return nil
        }
    }
    
    var name: String {
        switch self {
        case .fall:
            return "Осень"
            
        case .spring:
            return "Весна"
        }
    }
}
