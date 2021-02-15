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
        dataSource != nil ? ScheduleTableViewSection.allCases.count : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        
        let key = Array(dataSource.keys)[section]
        
        return dataSource[key]??.count ?? 0
//        return exercises != nil ? ScheduleTableViewItem.allCases.count : 0
    }
  
// TODO: fetch location from room by locationId
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = dataSource else { fatalError() }
        
        let key = Array(dataSource.keys)[indexPath.section]
        
        guard let exercises = dataSource[key],
              let exercise = exercises?[indexPath.item] else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EmptyExerciseTableViewCell.self)",
                                                           for: indexPath) as? EmptyExerciseTableViewCell  else {
                fatalError("Unknown collection view cell with type 'ExerciseTableViewCell'")
            }
            
            cell.title = "Нет занятяй"
            return cell
        }
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ExerciseTableViewCell.self)",
                                                       for: indexPath) as? ExerciseTableViewCell  else {
            fatalError("Unknown collection view cell with type 'ExerciseTableViewCell'")
        }
        
        let time = exerciseTime?[Int(exercise.pair)!]
        
        cell.type = exercise.type.capitalizingFirstLetter()
        cell.time = ("\(time?.start ?? "00:00") - \(time?.end ?? "00:00")")
        cell.name = exercise.name.capitalizingFirstLetter()
        cell.teacher = exercise.teachers

        roomService.getRoom(id: exercise.roomId) { result in
            switch result {
            case let .success(room):
                cell.place = room.name

            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        
        return cell
    }
}
