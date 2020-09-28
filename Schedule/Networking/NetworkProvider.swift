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
    
    private let timeoutInterval: Double = 10
    
    func request<Type: Decodable>(_ endpoint: Target, completion: @escaping (Result<Type>) -> Void) {
        AF.request("\(endpoint.baseURL)\(endpoint.path)",
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   headers: endpoint.headers) { urlRequest in
            urlRequest.timeoutInterval = self.timeoutInterval
        }
        .responseDecodable(of: Type.self) { response in
            switch response.result {
            case .success(let dto):
                completion(.success(dto))
            case .failure(let error):
                // TODO: handle error as Error type
                completion(.failure(error.errorDescription ?? "Network erro"))
            }
        }
    }
    
}
