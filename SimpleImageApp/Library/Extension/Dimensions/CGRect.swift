//
//  CGRect.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

extension CGRect {
    
    var smallDim: CGFloat { min(size.width, size.height) }
}
