//
//  NetworkProvider.swift
//  schedule
//
//  Created by vladislav on 26.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkProvider<Target: Endpoint> {
    
    private let timeoutInterval: Double
    
    init(timeoutInterval: Double = 14.0) {
        self.timeoutInterval = timeoutInterval
    }
    
    public func request<Type: Decodable>(_ endpoint: Target, completion: @escaping (Result<Type, UError>) -> Void) {
        AF.request("\(endpoint.baseURL)\(endpoint.path)",
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   headers: endpoint.headers) { urlRequest in
            urlRequest.timeoutInterval = self.timeoutInterval
        }
        .validate(statusCode: 200 ..< 300)
        .responseDecodable(of: Type.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                NSLog(error.localizedDescription)
                
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 400 ..< 500:
                        completion(.failure(.localBug))
                        
                    case 500 ..< 600:
                        completion(.failure(.internalServer))
                        
                    default:
                        completion(.failure(.networkConnection))
                    }
                } else {
                    completion(.failure(.networkConnection))
                }
                
            }
        }
    }
    
}
