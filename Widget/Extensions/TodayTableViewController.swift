//
//  TodayTableViewController.swift
//  Widget
//
//  Created by vladislav on 30.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  // Count of cells
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  // Cell setting
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "TodayCell", for: indexPath) as! TableViewCell

    let pair = array[indexPath.row].pair

    switch pair {
    case "1":
      cell.timeLabelText?.text = "09:30 - 11:00"
    case "2":
      cell.timeLabelText?.text = "11:30 - 13:00"
    case "3":
      cell.timeLabelText?.text = "14:00 - 15:30"
    case "4":
      cell.timeLabelText?.text = "16:00 - 17:30"
    default:
      break
    }

    cell.exerciseLabelText?.text = array[indexPath.row].name
 
    return cell
  }
  
}
