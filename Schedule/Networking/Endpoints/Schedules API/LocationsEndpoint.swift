//
//  LocationsEndpoint.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum LocationEndpoint {
    case get(name: String)
}

extension LocationEndpoint: ScheduleAPIEndpoint {
    var path: String {
        return "/locations"
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get(name: let name):
            return ["name" : name]
        }
    }
}
