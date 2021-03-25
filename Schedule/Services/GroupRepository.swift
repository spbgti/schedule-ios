//
//  GroupRepository.swift
//  schedule
//
//  Created by Vladislav Glumov on 22.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

final class GroupRepository {
    
    private var storageKey = UserDefaults.Key.group
    
    func getGroup(completion: @escaping (Result<Group, AppError>) -> Void) {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            completion(.failure(.noGroupData))
            return
        }
        
        do {
            let group = try JSONDecoder().decode(Group.self, from: data)
            completion(.success(group))
        } catch {
            completion(.failure(.noGroupData))
        }
    }
    
}
