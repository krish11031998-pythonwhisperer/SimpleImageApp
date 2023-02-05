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
        
        return UIImage.load(forUrl: urlStr)
            .observe(on: SerialDispatchQueueScheduler.init(qos: .background))
            .subscribe { [weak self] img in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.image = nil
                    UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve]) {
                        self.image = img
                    }
                }
            }
    }
    
}
