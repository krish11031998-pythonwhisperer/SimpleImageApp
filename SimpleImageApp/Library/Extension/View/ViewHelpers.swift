//
//  View.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

extension UIView {
    
    /// Loads View from a xib file
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self).first as? UIView
    }
    
    /// Spacer that can be added to the UIStackView for alignment purposes
    static func spacer() -> UIView {
        return .init()
    }
    
    /// Sets Corner Radius for layer
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /// Sets Corner Radius for a layer and clipstoBounds
    var clippedCornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
    
    /// Embed in View
    func embedView(inset: UIEdgeInsets) -> UIView {
        let view = UIView()
        view.addSubview(self)
        view.setFittingContraints(childView: self, insets: inset)
        return view
    }
    
    
    /// Applies Shadow
    func applyShadow(color: UIColor = .gray, radius: CGFloat = 1, opacity: Float = 0.5, offset: CGSize = .zero) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
    }
    
    /// Border Clipped
    func border(color: UIColor = .surfaceBackgroundInverse,
                width: CGFloat = 2,
                cornerRadius: CGFloat = 12) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
    }
}
