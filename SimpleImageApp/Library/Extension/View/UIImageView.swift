//
//  UIImageView.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

extension UIImageView {
    
    var circleFrame: CGRect {
        get { frame }
        set {
            frame = newValue
            clippedCornerRadius = newValue.smallDim.half
        }
    }
    
    /// Circlular ImageView
    convenience init(circleFrame: CGRect, backgroundColor: UIColor = .gray.withAlphaComponent(0.35)) {
        self.init(frame: circleFrame)
        self.clippedCornerRadius = circleFrame.smallDim.half
        self.backgroundColor = backgroundColor
        self.setFrame(width: circleFrame.width, height: circleFrame.height)
    }
    
    /// StandardImageView
    static func standardImageView(showBackground: Bool = false, cornerRadius: CGFloat = 12) -> UIImageView {
        let imageView = UIImageView()
        if showBackground {
            imageView.backgroundColor = .gray.withAlphaComponent(0.35)
        }
        imageView.clippedCornerRadius = cornerRadius
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    
    /// Sets up standImage Format
    func setupAsStandardImage(cornerRadius: CGFloat = 0) {
        backgroundColor = .gray.withAlphaComponent(0.35)
        clippedCornerRadius = cornerRadius
        contentMode = .scaleToFill
    }
    
}
