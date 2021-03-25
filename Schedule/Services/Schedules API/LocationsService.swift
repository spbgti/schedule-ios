//
//  LocationsService.swift
//  schedule
//
//  Created by vladislav on 30.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class LocationsService {
    
    private let provider = NetworkProvider<LocationEndpoint>()
    
    func getLocations(name: String, completion: @escaping (Result<[Location], AppError>) -> Void) {
        provider.request(.get(name: name)) { (result: Result<[Location], AppError>) in
            switch result {
            case .success(let locations):
                completion(.success(locations))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    func getLocation(id: Int, completion: @escaping (Result<Location, AppError>) -> Void) {
        provider.request(.getBy(id: id)) { (result: Result<Location, AppError>) in
            switch result {
            case .success(let locations):
                completion(.success(locations))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
}
