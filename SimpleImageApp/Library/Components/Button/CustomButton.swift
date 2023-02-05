//
//  ButtonView.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    private lazy var buttonConfiguration: UIButton.Configuration = {
        var config: UIButton.Configuration = .bordered()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .surfaceBackgroundInverse
        config.baseForegroundColor = .textColorInverse
        config.titleAlignment = .center
        return config
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        configuration = buttonConfiguration
        setFrame(height: 50)
        widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive  = true
        //titleLabel?.font = .systemFont(ofSize: 10, weight: .semibold)
    }
    
    override var isEnabled: Bool {
        didSet {
            UIView.transition(with: self, duration: 0.2) {
                if !self.isEnabled {
                    self.configuration?.baseBackgroundColor = .gray
                    self.isUserInteractionEnabled = false
                } else {
                    self.configuration?.baseBackgroundColor = .surfaceBackgroundInverse
                    self.isUserInteractionEnabled = true
                }
            }
        }
    }
}
