//
//  TeachersService.swift
//  schedule
//
//  Created by vladislav on 30.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class TeachersService {
    
    private let provider = NetworkProvider<TeachersEndpoint>()
    
    func getTeachers(name: String, completion: @escaping (Result<[Teacher], Errors>) -> Void) {
        provider.request(.get(name: name)) { (result: Result<[Teacher], Errors>) in
            switch result {
            case .success(let teachers):
                completion(.success(teachers))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    func getTeacher(id: Int, completion: @escaping (Result<Teacher, Errors>) -> Void) {
        provider.request(.getBy(id: id)) { (result: Result<Teacher, Errors>) in
            switch result {
            case .success(let teacher):
                completion(.success(teacher))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    
}
