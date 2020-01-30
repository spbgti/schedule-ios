//
//  Enums.swift
//  Schedule
//
//  Created by vladislav on 08.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(String)
}

enum WeekDaySection: Int, CaseIterable {
  case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday
  
  static var arrayOfCases: [WeekDaySection] {
    var arrayOfCases = Array<WeekDaySection>()
    
    for value in WeekDaySection.allCases {
      arrayOfCases.append(value)
    }
    
    return arrayOfCases
  }
}

enum NumberOfPair: Int, CaseIterable {
  case first = 0, second, third, fourth, fifth
}
