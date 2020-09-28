//
//  NetworkProvider.swift
//  schedule
//
//  Created by vladislav on 26.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Alamofire

class NetworkProvider<Target: Endpoint> {
    
    // TODO: create encoder variable
    // ...
    
    // TODO: return result using escaping closure
    // TODO: create completion: @escaping (Result<T>) -> Void
    func request(_ endpoint: Target) {
        AF.request("\(endpoint.baseURL)\(endpoint.path)",
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   headers: endpoint.headers) { urlRequest in
            urlRequest.timeoutInterval = 10
        }
        .response() { response in
            DispatchQueue.main.async {
                debugPrint(response)
            }
        }
        .cURLDescription { description in
            DispatchQueue.main.async {
                debugPrint(description)
            }
        }
    }
    
}
