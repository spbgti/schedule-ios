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
        dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let exercise = dataSource?[indexPath.item] else {
            fatalError("")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ExerciseTableViewCell.self)",
                                                       for: indexPath) as? ExerciseTableViewCell  else {
            fatalError("")
        }
        
        cell.type = exercise.type
        cell.time = exercise.pair
        cell.name = exercise.name
// TODO: set an array of teachers
        cell.teacher = exercise.teachers.first
// TODO: fetch room by roomId
// TODO: fetch location from room by locationId
        cell.place = String(exercise.roomId)
        cell.layoutIfNeeded()
        return cell
    }
}
