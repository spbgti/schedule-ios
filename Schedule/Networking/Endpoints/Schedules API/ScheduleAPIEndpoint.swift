//
//  BaseScheduleAPIEndpoint.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Alamofire

protocol ScheduleAPIEndpoint: Endpoint {}

extension ScheduleAPIEndpoint {
    var baseURL: String {
        return "https://spbgti-tools-schedule-staging.herokuapp.com/api"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
