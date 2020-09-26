//
//  NetworkProtocols.swift
//  schedule
//
//  Created by vladislav on 26.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Alamofire

protocol Endpoint {
    var baseURL: URL { get }
    var path: URL { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var queryParameters: URLQueryItem? { get }
}

extension Endpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var queryParameters: URLQueryItem? {
        return nil
    }
}
