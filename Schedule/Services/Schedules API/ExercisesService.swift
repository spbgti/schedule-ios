//
//  ExerciseService.swift
//  schedule
//
//  Created by vladislav on 29.09.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class ExercisesService {
    
    private let provider = NetworkProvider<ExercisesEndpoint>()
    
    func getExercises(groupId: Int, date: Date, completion: @escaping (Result<[Exercise], UError>) -> Void) {
        let dateString = dateFormatter(date)
        provider.request(.get(group: groupId, date: dateString)) { (result: Result<[Exercise], UError>) in
            switch result {
            case .success(let exercise):
                completion(.success(exercise))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    func getExercise(by id: Int, completion: @escaping (Result<Exercise, UError>) -> Void) {
        provider.request(.getBy(id: id)) { (result: Result<Exercise, UError>) in
            switch result {
            case .success(let exercise):
                completion(.success(exercise))
            case .failure(let errorString):
                completion(.failure(errorString))
            }
        }
    }
    
    private func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
}
