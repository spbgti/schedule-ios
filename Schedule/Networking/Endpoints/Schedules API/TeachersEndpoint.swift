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
}

extension TeachersEndpoint: ScheduleAPIEndpoint {
    var path: String {
        return "/teachers"
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get(name: let name):
            return ["name" : name]
        }
    }
    
}
