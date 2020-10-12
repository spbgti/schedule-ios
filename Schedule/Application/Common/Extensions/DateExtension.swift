//
//  DateExtension.swift
//  schedule
//
//  Created by vladislav on 12.12.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

extension Date {
  
  // MARK: - Today's date
  static var today: Date {
    return Date()
  }
  
  // MARK: - Tomorrow's date
  static var tomorrow:  Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: today)!
  }

  // MARK: - Current year
  static var year: Int {
      return Calendar.current.component(.year,  from: today)
  }
  
  // MARK: - From Date to String
  static func dateFormatter(date: Date, dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter.string(from: date)
  }
  
  // MARK: - From String to Date
  static func dateFormatter(date: String, dateFormat: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter.date(from: date)!
  }
  
}
