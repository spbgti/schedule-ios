//
//  ScheduleViewController + UITableViewDataSource.swift
//  schedule
//
//  Created by Vladislav Glumov on 12.02.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

extension ScheduleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let exercise = exercises?[indexPath.item],
              let exerciseTime = exerciseTime?[Int(exercise.pair)!] else {
            fatalError("")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ExerciseTableViewCell.self)",
                                                       for: indexPath) as? ExerciseTableViewCell  else {
            fatalError("Unknown collection view cell with type 'ExerciseTableViewCell'")
        }
        
        cell.type = exercise.type
        cell.time = ("\(exerciseTime.start) - \(exerciseTime.end)")
        cell.name = exercise.name
        cell.teacher = exercise.teachers
// TODO: fetch room by roomId
// TODO: fetch location from room by locationId
        cell.place = String(exercise.roomId)
        cell.selectionStyle = .none
        
        cell.layoutIfNeeded()
        
        return cell
    }
}
