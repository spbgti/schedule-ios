//
//  RoomsEndpoint.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum RoomsEndpoint {
    case get(name: String)
    case getBy(id: Int)
}

extension RoomsEndpoint: ScheduleAPIEndpoint {
    var path: String {
        switch self {
        case .get:
            return "/rooms"
        case .getBy(id: let id):
            return "/rooms/\(id)"
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
