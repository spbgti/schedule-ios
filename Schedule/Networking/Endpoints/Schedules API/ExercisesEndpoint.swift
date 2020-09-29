//
//  ExercisesEndpoint.swift
//  schedule
//
//  Created by vladislav on 27.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum ExercisesEndpoint {
    case getFor(group: Int, date: String)
    case getBy(id: Int)
}

extension ExercisesEndpoint: ScheduleAPIEndpoint {
    var path: String {
        switch self {
        case .getFor:
            return "/exercises"
        case .getBy(id: let id):
            return "/exercises/\(id)"
        }
        
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getFor(group: let id, date: let date):
            return ["group_id" : id, "date" : date]
        case .getBy:
            return nil
        }
    }
}
