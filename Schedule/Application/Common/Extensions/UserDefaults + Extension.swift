//
//  UserDefaultsKeys.swift
//  schedule
//
//  Created by Vladislav Glumov on 21.11.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Key {
        /// Key to return application locale with String type
        static let language: String = "APP_LANGUAGE"
        
        /// Key to return Bool value of
        static let isLaunchedBefore: String = "IS_LAUNCHED_BEFORE"
        
        /// Key to return group data
        static let group: String = "GROUP_DATA"
    }
}
