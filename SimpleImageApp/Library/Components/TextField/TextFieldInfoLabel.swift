//
//  TextFieldInfoLabel.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit

class TextFieldInfoLabel: UILabel {
    
    override var text: String? {
        didSet {
            DispatchQueue.main.async {
                UIView.transition(with: self, duration: 0.3) {
                    guard self.text != nil else {
                        self.isHidden = true
                        return
                    }
                    self.isHidden = false
                }
            }
        }
    }
    
}
