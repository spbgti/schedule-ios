//
//  TodayTableViewController.swift
//  Widget
//
//  Created by vladislav on 30.10.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
  
  // Count of cells
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  // Cell setting
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "TodayCell", for: indexPath) as!  TableViewCell
    let pair = array[indexPath.row].pair

    switch pair {
    case "1":
      cell.timeLabelText?.text = "09:30\n11:00"
    case "2":
      cell.timeLabelText?.text = "11:30\n13:00"
    case "3":
      cell.timeLabelText?.text = "14:00\n15:30"
    case "4":
      cell.timeLabelText?.text = "16:00\n17:30"
    case "5":
      cell.timeLabelText?.text = "17:45\n19:15"
    default:
      break
    }

    cell.exerciseLabelText?.text = array[indexPath.row].name
 
    return cell
  }
  
}
