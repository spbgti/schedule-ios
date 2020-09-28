//
//  ExercisesEndpoint.swift
//  schedule
//
//  Created by vladislav on 27.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum ExercisesEndpoint {
    case get(groupId: Int, date: String)
}

extension ExercisesEndpoint: ScheduleAPIEndpoint {
    var path: String {
        return "/exercises"
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get(groupId: let id, date: let date):
            return ["group_id" : id, "date" : date]
        }
    }
}
