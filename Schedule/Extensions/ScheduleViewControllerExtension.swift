//
//  UIViewController.swift
//  schedule
//
//  Created by vladislav on 25.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {

  // Count of sections
  func numberOfSections(in tableView: UITableView) -> Int {
    if segmentedControl.selectedSegmentIndex == 2 {
      return WeekDaySection.allCases.count
    } else {
      return 1
    }
  }
  
  // Section settings
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 22.0)
    
    if self.sortedExercises.isEmpty {
      Alert.showBasicAlert(on: self, message: "No data found", with: "Unable to retrieve data")
    } else {
      let numberOfSection = numberOfSections(in: tableView)
      var tableSection: WeekDaySection
      
      if numberOfSection > 1 {
        let arrayOfWeekDaySectionCases = WeekDaySection.arrayOfCases
        tableSection = arrayOfWeekDaySectionCases[section]
      } else {
        // FIXME: insert value from func 'getWeekday()', not from array
        // TODO: check relevance data
        let sortedExerciseKeys =  Array(sortedExercises.keys)
        tableSection = sortedExerciseKeys[section]
      }
      
      switch tableSection {
      case .monday:
        label.text = "Понедельник"
      case .tuesday:
        label.text = "Вторник"
      case .wednesday:
        label.text = "Среда"
      case .thursday:
        label.text = "Четверг"
      case .friday:
        label.text = "Пятница"
      case .saturday:
        label.text = "Суббота"
      case .sunday:
        label.text = "Воскресенье"
      }
    }
    
    return label
  }
  
  // Count of cells
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NumberOfPair.allCases.count
  }
  
  // Cell settings
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScheduleTableViewCell
    let numberOfSection = numberOfSections(in: tableView)
    let cellRow = indexPath.row
    
    switch cellRow {
    case 0:
      cell.timeLabel?.text = "09:30\n11:00"
    case 1:
      cell.timeLabel?.text = "11:30\n13:00"
    case 2:
      cell.timeLabel?.text = "14:00\n15:30"
    case 3:
      cell.timeLabel?.text = "16:00\n17:30"
    case 4:
      cell.timeLabel?.text = "17:45\n19:15"
    default:
      break
    }
    
    if sortedExercises.isEmpty {
      cell.exerciseLabel?.text = ""
      cell.parityLabelText?.text = ""
      Alert.showBasicAlert(on: self, message: "No data found", with: "Unable to retrieve data")
    } else {
      var keys: [WeekDaySection]
      var weekDaySection: WeekDaySection
      var arrayOfExercises: [Exercise]
      
      if numberOfSection == 1 {
        keys = Array(sortedExercises.keys)
        weekDaySection = keys[indexPath.section]
        arrayOfExercises = sortedExercises[weekDaySection]!
        
      } else {
        weekDaySection = WeekDaySection.arrayOfCases[indexPath.section]
        arrayOfExercises = sortedExercises[weekDaySection]!
      }
      
      for obj in arrayOfExercises {
        let exerciseName = obj.name
        let exercisePair = obj.pair
        let exerciseParity = obj.parity
        
        if exercisePair == String(indexPath.row + 1) {
          cell.exerciseLabel?.text = exerciseName
          switch exerciseParity {
          case "1":
            cell.parityLabelText?.text = "нечет."
          case "2":
            cell.parityLabelText?.text = "четн."
          default:
            cell.parityLabelText?.text = ""
          }
          break
        } else {
          cell.exerciseLabel?.text = "-"
          cell.parityLabelText?.text = ""
        }
      }
    }
    
    return cell
  }
  
}
