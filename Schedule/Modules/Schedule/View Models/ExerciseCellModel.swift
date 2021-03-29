//
//  ExerciseCellModel.swift
//  schedule
//
//  Created by Vladislav Glumov on 15.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

struct ExerciseCellModel {
    let pair: String
    let type: String?
    let time: String
    
    let name: String
    let teachers: String?
    let location: String?
    
    init(exercise: Exercise, time: ExerciseTime, room: Room, location: Location?) {
        self.pair = exercise.pair
        self.type = exercise.type.capitalizingFirstLetter()
        self.time = "\(time.start) - \(time.end)"
        self.name = exercise.name.capitalizingFirstLetter()
        self.teachers = exercise.teachers.joined(separator: ", ")
        self.location = "Аудитория: \(room.name) (\(location?.name ?? ""))"
    }
}
