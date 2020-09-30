//
//  TeachersEndpoint.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum TeachersEndpoint {
    case get(name: String)
    case getBy(id: Int)
}

extension TeachersEndpoint: ScheduleAPIEndpoint {
    var path: String {
        switch self {
        case .get:
            return "/teachers"
        case .getBy(id: let id):
            return "/teachers/\(id)"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get(name: let name):
            return ["name" : name]
        case .getBy:
            return nil
        }
    }
    
}
