//
//  String + Extension.swift
//  schedule
//
//  Created by Vladislav Glumov on 21.11.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

// MARK: - Extension Of String Localization

extension String {
    var localized: String {
        let languageKey: String = UserDefaults.Key.language
        let lang: String
        
        // Check language setting or set default locale
        if let locale: String = UserDefaults.standard.string(forKey: languageKey) {
            lang = locale
        } else {
            let locale: String = "ru"
            lang = locale
            UserDefaults.standard.set(locale, forKey: languageKey)
        }
            
        // Set localized string in app
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)

        // Return localized string value
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
