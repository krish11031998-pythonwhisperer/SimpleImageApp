//
//  EdgeInsets.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    
    init(by: CGFloat) {
        self.init(top: by, left: by, bottom: by, right: by)
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}


extension NSDirectionalEdgeInsets {
    
    init(by: CGFloat) {
        self.init(top: by, leading: by, bottom: by, trailing: by)
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
