//
//  ViewController.swift
//  VuzAssessment
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
    
    //MARK: - Exposed Methods
    func setupNavBar(title: String? = nil) {
        guard let nav = navigationController,
              nav.viewControllers.count > 1 else {
            mainNavBar(title: title)
            return
        }
        
        setupStandardNavbar(title: title)
    }
    
    func pushTo(_ target: UIViewController) {
        self.navigationController?.pushViewController(target, animated: true)
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = .init(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    //MARK: - Protected Methods
    private func setupView() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let views = navigationController?.viewControllers, views.count > 1  else { return false }
        return true
    }
}
