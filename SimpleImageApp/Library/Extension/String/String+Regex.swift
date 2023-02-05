//
//  String+Regex.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation

extension String {
    
    func isValidWith(regex: String) -> Bool {
        
        guard let gRegex = try? NSRegularExpression(pattern: regex) else {
            return false
        }

        let range = NSRange(location: 0, length: self.utf16.count)
        
        if gRegex.firstMatch(in: self, options: [], range: range) != nil {
            return true
        }
        
        return false
    }
}
