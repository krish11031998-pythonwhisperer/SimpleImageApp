//
//  ViewController+NavBar.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupStandardNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .surfaceBackground
        appearance.backgroundImage = nil
        appearance.shadowColor = .clear
        
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.compactAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.standardAppearance = appearance
    }
    
    func mainNavBar(title: String? = nil) {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = title
        label.textColor = .textColor
  
        navigationItem.leftBarButtonItem = .init(customView: label)
        setupStandardNavBarAppearance()
    }
    
    func setupStandardNavbar(title: String? = nil) {
        setupStandardNavBarAppearance()
        navigationItem.leftBarButtonItem = standardBackButton()
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = title
        label.textColor = .textColor
        
        navigationItem.titleView = label
    }

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
    
}


//MARK: - Navbar + BarButtonItem
extension UIViewController {
    
    func standardBackButton() -> UIBarButtonItem {
        let img = UIImage(systemName: "chevron.left")?.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal)
        let item = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(goBack))
        return item
    }
    
    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
