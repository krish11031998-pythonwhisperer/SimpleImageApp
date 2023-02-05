//
//  UIImageView+UIImage.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit
import RxSwift

extension UIImageView {
    
    func loadImage(forURL urlStr: String) -> Disposable {
        image = nil
        return UIImage.load(forUrl: urlStr)
            .subscribe { [weak self] img in
                DispatchQueue.main.async {
                    self?.image = img
                }
            }
    }
    
}
