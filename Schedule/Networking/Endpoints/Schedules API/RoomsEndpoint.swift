//
//  RoomsEndpoint.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum RoomsEndpoint {
    case get(name: String, location: String)
}

extension RoomsEndpoint: ScheduleAPIEndpoint {
    var path: String {
        return "/rooms"
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get(name: let name, location: let location):
            return ["name" : name, "location" : location]
        }
    }
}
