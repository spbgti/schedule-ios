//
//  SchedulesEndpoint.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum SchedulesEndpoint {
    case get(year: String, semester: String, groupNumber: String)
}

extension SchedulesEndpoint: ScheduleAPIEndpoint {
    var path: String {
        return "/schedules"
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get(year: let year, semester: let semester, groupNumber: let group):
            return ["year" : year, "semester" : semester, "group_number" : group]
        }
    }
}
