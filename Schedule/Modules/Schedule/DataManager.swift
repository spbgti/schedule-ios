//
//  DataManager.swift
//  schedule
//
//  Created by vladislav on 16.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class DataManager {
  
  // MARK: Properties
  
  private(set) var storage = [WeekDaySection: [Exercise]]()
  
  public var keys: [WeekDaySection] {
    return Array(storage.keys)
  }
  
  // MARK: Methods
  
  func overwrite(_ array: [Exercise]) {
    removeAll()
    
    for item in array {
      switch item.day {
        case "1":
          storage[.monday] = array.filter({ $0.day == "1" })
        case "2":
          storage[.tuesday] = array.filter({ $0.day == "2" })
        case "3":
          storage[.wednesday] = array.filter({ $0.day == "3" })
        case "4":
          storage[.thursday] = array.filter({ $0.day == "4" })
        case "5":
          storage[.friday] = array.filter({ $0.day == "5" })
        case "6":
          storage[.saturday] = array.filter({ $0.day == "6" })
        case "7":
          storage[.sunday] = array.filter({ $0.day == "7" })
        default:
          break
      }
    }
  }
  
  func removeAll() {
    self.storage.removeAll()
  }
  
}
