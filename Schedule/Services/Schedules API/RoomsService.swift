//
//  RoomsService.swift
//  schedule
//
//  Created by vladislav on 30.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class RoomsService {
    
    private let provider = NetworkProvider<RoomsEndpoint>()
    
    func getRooms(name: String, completion: @escaping (Result<[Room], UError>) -> Void) {
        provider.request(.get(name: name)) { (result: Result<[Room], UError>) in
            switch result {
            case .success(let rooms):
                completion(.success(rooms))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    func getRoom(id: Int, completion: @escaping (Result<Room, UError>) -> Void) {
        provider.request(.getBy(id: id)) { (result: Result<Room, UError>) in
            switch result {
            case .success(let room):
                completion(.success(room))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
}
