//
//  TableViewExtension.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

extension NSObject {
    static var name: String { "\(self)"}
}

extension UITableView {
    
    func registerCell(type: AnyClass, identifier: String, fromBundle: Bundle? = nil) {
        let bundle = fromBundle ?? Bundle(for: type)
        if bundle.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
        } else {
            register(type, forCellReuseIdentifier: identifier)
        }
    }
    
    func dequeueCell<Cell: ConfigurableCell>(indexPath: IndexPath) -> Cell {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.name) as? Cell else {
            registerCell(type: Cell.self, identifier: Cell.name)
            return dequeueReusableCell(withIdentifier: Cell.name, for: indexPath) as? Cell ?? Cell()
        }
        return cell
    }
    
}


extension UITableView {
    
    static func standardTableView() -> UITableView {
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }
    
}
