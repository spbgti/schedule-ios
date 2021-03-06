//
//  GroupsService.swift
//  schedule
//
//  Created by vladislav on 30.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class GroupsService {
    
    private let provider = NetworkProvider<GroupsEndpoint>()
    
    func getGroups(number: String, completion: @escaping (Result<[Group]>) -> Void) {
        provider.request(.get(number: number)) { (result: Result<[Group]>) in
            switch result {
            case .success(let groups):
                completion(.success(groups))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    func getGroup(id: Int, completion: @escaping (Result<Group>) -> Void) {
        provider.request(.getBy(id: id)) { (result: Result<Group>) in
            switch result {
            case .success(let group):
                completion(.success(group))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
}
