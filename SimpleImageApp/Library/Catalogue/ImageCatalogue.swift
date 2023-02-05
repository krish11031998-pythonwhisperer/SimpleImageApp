//
//  ImageCatalogue.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit

enum ColorCatalogue: String {
    
    case surfaceBackground
    case surfaceBackgroundInverse
    case textColor
    case textColorInverse
}

extension ColorCatalogue {
    
    var color: UIColor {
        .init(named: rawValue) ?? .clear
    }
    
}

extension UIColor {
    
    static var surfaceBackground: UIColor { ColorCatalogue.surfaceBackground.color }
    static var surfaceBackgroundInverse: UIColor { ColorCatalogue.surfaceBackgroundInverse.color }
    static var textColor: UIColor { ColorCatalogue.textColor.color }
    static var textColorInverse: UIColor { ColorCatalogue.textColorInverse.color }
    
}
