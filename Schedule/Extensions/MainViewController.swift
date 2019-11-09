//
//  UIViewController.swift
//  schedule
//
//  Created by vladislav on 25.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource and UITableViewDelegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  // Section setting
  enum TableSection: Int {
    case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.backgroundColor = UIColor.lightGray
    
    if let tableSection = TableSection(rawValue: section) {
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
  
  // Count of sections
  func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }
  
  // Count of cells
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tableSection = TableSection(rawValue: section), let weekData = data[tableSection] {
      return weekData.count
    }
    
    return 0
  }
  
  // Cell setting
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
    
    if let tableSection = TableSection(rawValue: indexPath.section), let exercise = data[tableSection]?[indexPath.row] {
      let pair = exercise.pair
      let parity = exercise.parity
      
      switch pair {
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
      
      switch parity {
      case "1":
        cell.parityLabelText?.text = "нечет."
      case "2":
        cell.parityLabelText?.text = "четн."
      default:
        cell.parityLabelText?.text = ""
      }
      
      cell.exerciseLabel?.text = exercise.name
    }
    
    return cell
  }
  
}
