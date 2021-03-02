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
        dataSource != nil ? Weekday.allCases.count : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return dataSource[Weekday.allCases[section]] != nil ? ExerciseNumber.allCases.count : 1
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = dataSource, let valueOfDictionary = dataSource[Weekday.allCases[indexPath.section]] else {
            fatalError("")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ExerciseTableViewCell.self)", for: indexPath) as? ExerciseTableViewCell else {
            fatalError("Unknown type 'ExerciseTableViewCell'")
        }
        
        if let exercises = valueOfDictionary {
            cell.set(exercises[indexPath.item])
        } else {
            cell.message = "Выходной день"
        }
        
        return cell
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(ScheduleTableViewSectionHeader.self)") as? ScheduleTableViewSectionHeader else {
            fatalError("Unknown type 'ScheduleTableViewSectionHeader'")
        }
        
        headerView.title = Weekday.allCases[section].rawValue.capitalizingFirstLetter()
        headerView.layoutIfNeeded()
        return headerView
    }
}
