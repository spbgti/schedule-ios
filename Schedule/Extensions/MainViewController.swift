//
//  UIViewController.swift
//  schedule
//
//  Created by vladislav on 25.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource and UITableViewDelegate

extension ViewController: UITableViewDataSource {
  
  enum TableSection: Int {
    case action = 0, comedy, drama, indie, total
  }
  
  // Section setting
//  private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> UIView? {
//    let label = UILabel()
//    label.text = "Week day"
//    label.backgroundColor = UIColor.lightGray
//
//    return label
//  }
  
  // Count of sections
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  // Count of cells
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  // Cell setting
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CustomTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
    
    let pair = array[indexPath.row].pair
    
    switch pair {
    case "1":
      cell.timeLabel?.text = "09:30 - 11:00"
    case "2":
      cell.timeLabel?.text = "11:30 - 13:00"
    case "3":
      cell.timeLabel?.text = "14:00 - 15:30"
    case "4":
      cell.timeLabel?.text = "16:00 - 17:30"
    default:
      break
    }
    
    cell.exerciseLabel?.text = array[indexPath.row].name
    
    return cell
  }
  
}
