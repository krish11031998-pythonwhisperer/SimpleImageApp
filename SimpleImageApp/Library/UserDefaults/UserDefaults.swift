//
//  UserDefaults.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import Foundation
enum UserDefaultStoreKey: String {
    case loggedIn
    case email
    case password
}

extension UserDefaultStoreKey {
    
    func value<T>() -> T? {
        UserDefaults.standard.object(forKey: self.rawValue) as? T
    }
    
    func setValue<T>(_ value: T) {
        UserDefaults.standard.set(value, forKey: self.rawValue)
    }
    
}
