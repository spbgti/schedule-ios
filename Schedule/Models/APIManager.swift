//
//  APIManager.swift
//  schedule
//
//  Created by vladislav on 27.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class APIManager {
  
  // MARK: Singletone Implementation
 
  static let shared = APIManager()
  private init() {}
  
  // MARK: Properties
  
  private let pathToAPI = "https://spbgti-tools-schedule-staging.herokuapp.com/api/"
  
  // MARK: Methods
  
  func getGroups(groupNumber: String, completionHandler: @escaping(Result<[Group]>) -> Void) {
    let urlRequest = "\(pathToAPI)groups?number=\(groupNumber)"

    NetworkConnection.shared.getData(url: urlRequest) { (completion: Result<[Group]>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          if result.count != 0 {
            completionHandler(.success(result))
          } else {
            completionHandler(.failure("Invalid group number"))
          }
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
  func getExercises(date: String, completionHandler: @escaping(Result<[Exercise]>) -> Void) {
    guard let groupId = UserDefaultsManager.shared.getObject(forKey: "GROUP_ID") else {
      completionHandler(.failure("Group number not found. Check your setting"))
      return
    }
    
    let urlRequest = "\(pathToAPI)exercises?group_id=\(groupId)&date=\(date)"
    
    NetworkConnection.shared.getData(url: urlRequest) { (completion: Result<[Exercise]>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          completionHandler(.success(result))
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }

  func getSchedules(year: String, completionHandler: @escaping(Result<[Exercise]>) -> Void) {
    guard let groupNumber = UserDefaultsManager.shared.getObject(forKey: "GROUP_NUMBER") else {
      completionHandler(.failure("Group number not found. Check your setting"))
      return
    }
    
    let urlRequest = "\(pathToAPI)schedules?year=\(year)&group_number=\(groupNumber)"

    NetworkConnection.shared.getData(url: urlRequest) { (completion: Result<[Schedule]>) in
      DispatchQueue.main.async {
        switch completion {
        case .success(let result):
          completionHandler(.success(result[0].exercises))
        case .failure(let error):
          completionHandler(.failure(error))
        }
      }
    }
  }
  
}
