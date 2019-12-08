//
//  UIViewController.swift
//  schedule
//
//  Created by vladislav on 25.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

// MARK: - Kind of section
enum WeekDaySection: Int {
  case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

  // Count of sections
  func numberOfSections(in tableView: UITableView) -> Int {
    return sortedExercises.count
  }
  
  // Section settings
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 22.0)
    
    let keys = Array(sortedExercises.keys)
    
    if let tableSection = keys[section] as? WeekDaySection {
      switch tableSection {
      case .monday:
        label.text = "Monday"
      case .tuesday:
        label.text = "Tuesday"
      case .wednesday:
        label.text = "Wednesday"
      case .thursday:
        label.text = "Thursday"
      case .friday:
        label.text = "Friday"
      case .saturday:
        label.text = "Saturday"
      case .sunday:
        label.text = "Sunday"
      }
    }
    
    return label
  }
  
  // Count of cells
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let keys = Array(sortedExercises.keys)
    
    if let tableSection = keys[section] as? WeekDaySection, let exerciseArray = sortedExercises[tableSection] {
      return exerciseArray.count
    }
    
    return 0
  }
  
  // Cell settings
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
    let keys = Array(sortedExercises.keys)
    
    if let tableSection = keys[indexPath.section] as? WeekDaySection, let sortedExercises = sortedExercises[tableSection]?[indexPath.row] {
      let exercisePair = sortedExercises.pair
      let exerciseParity = sortedExercises.parity
      let exerciseName = sortedExercises.name
      
      switch exercisePair {
      case "1":
        cell.timeLabel?.text = "09:30\n11:00"
      case "2":
        cell.timeLabel?.text = "11:30\n13:00"
      case "3":
        cell.timeLabel?.text = "14:00\n15:30"
      case "4":
        cell.timeLabel?.text = "16:00\n17:30"
      case "5":
        cell.timeLabel?.text = "17:45\n19:15"
      default:
        break
      }
      
      switch exerciseParity {
      case "1":
        cell.parityLabelText?.text = "нечет."
      case "2":
        cell.parityLabelText?.text = "четн."
      default:
        cell.parityLabelText?.text = ""
      }
      
      cell.exerciseLabel?.text = exerciseName
    }
    
    return cell
  }
  
}
