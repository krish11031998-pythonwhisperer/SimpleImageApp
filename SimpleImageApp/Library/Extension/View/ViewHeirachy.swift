//
//  ViewHeirachy.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

extension UIView {
    /// Helps sets contraints between the child and superview with individual constant values
    func setFittingContraints(childView: UIView, top: CGFloat? = nil, leading: CGFloat? = nil, bottom: CGFloat? = nil, trailing: CGFloat? = nil, centerX: CGFloat? = nil, centerY: CGFloat? = nil) {
        
        var newConstraints: [NSLayoutConstraint] = []
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        if let validTop = top {
            newConstraints.append(childView.topAnchor.constraint(equalTo: topAnchor, constant: validTop))
        }
        
        if let validBottom = bottom {
            newConstraints.append(childView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -validBottom))
        }
        
        if let validLeading = leading {
            newConstraints.append(childView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: validLeading))
        }
        
        if let validTrailing = trailing {
            newConstraints.append(childView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -validTrailing))
        }
        
        if let validCenterX = centerX {
            newConstraints.append(childView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: validCenterX))
        }
        
        if let validCenterY = centerY {
            newConstraints.append(childView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: validCenterY))
        }
        
        removeSimilarConstraints(newConstraints)
        addConstraints(newConstraints)
    }
    
    /// Helps sets contraints between the child and superview with insets provided in the form of UIEdgeInsets
    func setFittingContraints(childView: UIView, insets: UIEdgeInsets) {
        setFittingContraints(childView: childView, top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
    }
    
    /// Sets Frame for View
    func setFrame(width: CGFloat? = nil, height: CGFloat? = nil) {
        var frameConstraints: [NSLayoutConstraint] = []
        if let validWidth = width {
            frameConstraints.append(widthAnchor.constraint(equalToConstant: validWidth))
        }
        
        if let validHeight = height {
            frameConstraints.append(heightAnchor.constraint(equalToConstant: validHeight))
        }
        removeSimilarConstraints(frameConstraints)
        addConstraints(frameConstraints)
    }
    
    /// removeSimilarConstraints
    func removeSimilarConstraints(_ list: [NSLayoutConstraint]) {
        constraints.forEach {
            guard let const = list.filter($0.isSame(constraint:)).first else { return }
            removeConstraint(const)
        }
    }
    
}

extension NSLayoutConstraint {
    
    func isSame(constraint: NSLayoutConstraint) -> Bool {
        firstAnchor === constraint.firstAnchor &&
        secondAnchor === constraint.secondAnchor &&
        firstItem === constraint.firstItem &&
        secondItem === constraint.secondItem
    }
}
