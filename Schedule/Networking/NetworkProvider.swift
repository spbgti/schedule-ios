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
    
    public func request<Type: Decodable>(_ endpoint: Target, completion: @escaping (Result<Type, AppError>) -> Void) {
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
                
            case .failure(_):
                if response.response?.statusCode != nil {
                    completion(.failure(.serverError))
                } else {
                    completion(.failure(.noInternetConnection))
                }
                
            }
        }
    }
    
}
