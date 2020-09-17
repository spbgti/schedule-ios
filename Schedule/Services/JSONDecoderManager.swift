//
//  JSONDecoderManager.swift
//  schedule
//
//  Created by vladislav on 16.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class JSONDecoderManager {
  
  // MARK: Singletone Implementation
  
  static var shared = JSONDecoderManager()
  private init() {}
  
  // MARK: Properties
  
  private let jsonDecoder = JSONDecoder()
  
  // MARK: Methods
  
  func decode<T: Decodable>(from data: Data, type: T.Type) -> Result<T> {
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    
    do {
      let object = try jsonDecoder.decode(T.self, from: data)
      return .success(object)
    } catch let error {
      return .failure(error.localizedDescription)
    }
  }
  
}
