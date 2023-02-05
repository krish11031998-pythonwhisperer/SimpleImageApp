//
//  TextFieldInfoLabel.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit

class TextFieldInfoLabel: UILabel {
    
    override var text: String? {
        didSet {
            UIView.transition(with: self, duration: 0.3) {
                guard let text = self.text else {
                    self.isHidden = true
                    return
                }
                self.isHidden = false
            }
        }
    }
    
}
