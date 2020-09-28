//
//  GroupsEndpoint.swift
//  schedule
//
//  Created by vladislav on 28.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum GroupsEndpoint {
    case get(number: String)
}

extension GroupsEndpoint: ScheduleAPIEndpoint {
    var path: String {
        return "/groups"
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get(number: let number):
            return ["number" : number]
        }
    }
}
