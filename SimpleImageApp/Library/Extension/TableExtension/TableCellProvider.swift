//
//  TableCellProvider.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

//MARK: - Configurable
protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}

//MARK: - ConfigurableCell
typealias ConfigurableCell = Configurable & UITableViewCell


//MARK: - TableCellProvider
protocol TableCellProvider {
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectAt(tableView: UITableView, indexPath: IndexPath)
}

//MARK: - TableRow
struct TableRow<Cell: ConfigurableCell>: TableCellProvider {
    
    var model: Cell.Model
    
    init(_ model: Cell.Model) {
        self.model = model
    }
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueCell(indexPath: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func didSelectAt(tableView: UITableView, indexPath: IndexPath)  {
        guard let actionableModel = model as? ActionProvider else { return }
        actionableModel.action?()
    }
}
