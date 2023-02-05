//
//  ViewController.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    //MARK: - Overriden Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Protected Methods
    private func setupView() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        let edittingGesture = UITapGestureRecognizer(target: self, action: #selector(endEditting))
        edittingGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(edittingGesture)
    }
    
    @objc
    private func endEditting() {
        view.endEditing(true)
        
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let views = navigationController?.viewControllers, views.count > 1  else { return false }
        return true
    }
}
