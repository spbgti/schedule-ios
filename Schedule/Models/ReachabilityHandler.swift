//
//  ReachabilityHandler.swift
//  schedule
//
//  Created by vladislav on 08.01.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Reachability

fileprivate var reachability: Reachability!

protocol ReachabilityActionDelegate {
  func reachabilityChanged(_ isReachable: Bool)
}

protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver() throws
    func removeReachabilityObserver()
}

extension ReachabilityObserverDelegate {
  func addReachabilityObserver() throws {
      reachability = try Reachability()
      
      reachability.whenReachable = { [weak self] reachability in
          self?.reachabilityChanged(true)
      }
      
      reachability.whenUnreachable = { [weak self] reachability in
          self?.reachabilityChanged(false)
      }
      
      try reachability.startNotifier()
  }
  
  func removeReachabilityObserver() {
      reachability.stopNotifier()
      reachability = nil
  }
}

class ReachabilityHandler: ReachabilityObserverDelegate {
  
  required init() {
    try? addReachabilityObserver()
  }
  
  deinit {
    removeReachabilityObserver()
  }
    
  func reachabilityChanged(_ isReachable: Bool) {
    if !isReachable {
        print("No internet connection")
    }
  }
  
}
