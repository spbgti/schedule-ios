//
//  UIViewController.swift
//  schedule
//
//  Created by vladislav on 25.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension DataProvider: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    if dataManager.keys.count > 1 {
      return WeekDaySection.arrayOfCases.count
    } else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if dataManager.storage.isEmpty {
      return nil
    } else {
      let numberOfSection = numberOfSections(in: tableView)
      var tableSection: WeekDaySection
      
      if numberOfSection > 1 {
        let arrayOfWeekDaySectionCases = WeekDaySection.arrayOfCases
        tableSection = arrayOfWeekDaySectionCases[section]
      } else {
        let sortedExerciseKeys =  dataManager.keys
        tableSection = sortedExerciseKeys[section]
      }
      
      switch tableSection {
      case .monday:
        return "Понедельник"
      case .tuesday:
        return "Вторник"
      case .wednesday:
        return "Среда"
      case .thursday:
        return "Четверг"
      case .friday:
        return"Пятница"
      case .saturday:
        return "Суббота"
      case .sunday:
        return "Воскресенье"
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if dataManager.storage.isEmpty {
      return 1
    } else {
      return NumberOfPair.allCases.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCellIdentifier", for: indexPath) as! ScheduleTableViewCell
    let numberOfSection = numberOfSections(in: tableView)
    let cellRow = indexPath.row
    
    // FIX: Use custom cell for error
    if dataManager.storage.isEmpty {
      cell.textLabel?.text = "Data not found"
    } else {
      cell.textLabel?.text = ""
      var keys: [WeekDaySection]
      var weekDaySection: WeekDaySection
      var arrayOfExercises: [Exercise]
      
      if numberOfSection == 1 {
        keys = Array(dataManager.storage.keys)
        weekDaySection = keys[indexPath.section]
        arrayOfExercises = dataManager.storage[weekDaySection]!
      } else {
        weekDaySection = WeekDaySection.arrayOfCases[indexPath.section]
        arrayOfExercises = dataManager.storage[weekDaySection]!
      }
      
      switch cellRow {
      case 0:
        cell.timeLabel.text = "09:30\n11:00"
      case 1:
        cell.timeLabel.text = "11:30\n13:00"
      case 2:
        cell.timeLabel.text = "14:00\n15:30"
      case 3:
        cell.timeLabel.text = "16:00\n17:30"
      case 4:
        cell.timeLabel.text = "17:45\n19:15"
      default:
        break
      }
      
      for obj in arrayOfExercises {
        let exerciseName = obj.name
        let exercisePair = obj.pair
        let exerciseParity = obj.parity
        
        if exercisePair == String(indexPath.row + 1) {
          cell.exerciseLabel.text = exerciseName
          switch exerciseParity {
          case "1":
            cell.parityLabel.text = "нечет."
          case "2":
            cell.parityLabel.text = "четн."
          default:
            cell.parityLabel.text = ""
          }
          break
        } else {
          cell.parityLabel.text = ""
          cell.exerciseLabel.text = "-"
        }
      }
    }
    
    return cell
  }
  
}
