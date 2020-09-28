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
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String : Any]? { get }
}
