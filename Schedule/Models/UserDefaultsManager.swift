//
//  UserDefaultsManager.swift
//  schedule
//
//  Created by vladislav on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

// TODO: Refactor the model init()
class UserDefaultsManager {
  
  static let shared = UserDefaultsManager()
  private let userDefaults: UserDefaults
  
  private init() {
    userDefaults = UserDefaults.init(suiteName: "group.mac.schedule.sharingData")!
  }
  
  func setObject(_ value: Any, forKey: String) {
    userDefaults.set(value, forKey: forKey)
  }
  
  func getObject(forKey: String) -> Any? {
    return userDefaults.object(forKey: forKey)
  }
  
  func removeObject(forKey: String) {
    userDefaults.removeObject(forKey: forKey)
  }
  
}
