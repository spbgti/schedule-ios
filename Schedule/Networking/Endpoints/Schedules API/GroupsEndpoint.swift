//
//  GroupsEndpoint.swift
//  schedule
//
//  Created by vladislav on 28.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum GroupsEndpoint {
    case get(number: String?)
    case getBy(id: Int)
}

extension GroupsEndpoint: ScheduleAPIEndpoint {
    var path: String {
        
        switch self {
        case .get:
            return "/groups"
        case .getBy(id: let id):
            return "/groups/\(id)"
        }
        
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .get(number: let number):
            return number != nil ? ["number" : number!]: nil
        case .getBy:
            return nil
        }
    }
}
