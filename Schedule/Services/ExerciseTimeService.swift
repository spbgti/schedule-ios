//
//  ExerciseTimeService.swift
//  schedule
//
//  Created by Vladislav Glumov on 25.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

final class ExerciseTimeService {
    
    func get(completion: @escaping (Result<[ExerciseTime], AppError>) -> Void) {
        guard let data = NSDataAsset(name: "ExerciseTime", bundle: .main) else {
            fatalError("Unknown 'ExerciseTime' name of NSDataAssets object")
        }
        
        do {
            let exerciseTime = try JSONDecoder().decode([ExerciseTime].self, from: data.data)
            completion(.success(exerciseTime))
        } catch {
            completion(.failure(.serverError))
        }
    }
    
}
