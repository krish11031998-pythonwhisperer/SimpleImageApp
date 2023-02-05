//
//  TalbeSection.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

//MARK: - TableSection
struct TableSection {
    let rows: [TableCellProvider]
    let customHeader: UIView?
    let heading: String?
    
    init(rows: [TableCellProvider], customHeader: UIView? = nil, heading: String? = nil) {
        self.rows = rows
        self.customHeader = customHeader
        self.heading = heading
    }
}


//MARK: - TableDataSource
class TableDataSource: NSObject {
    var sections: [TableSection]
    
    init(sections: [TableSection]) {
        self.sections = sections
    }
}

extension TableDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].rows[indexPath.row].cellForRowAt(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = sections[section].heading
        return label.embedView(inset: .init(top: 20, left: 20, bottom: 4, right: 20))
    }
}

extension TableDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return sections[indexPath.section].rows[indexPath.row].didSelectAt(tableView: tableView, indexPath: indexPath)
    }
    
}


//MARK: - UITableView + TableDataSource
extension UITableView {
    
    static var dataSoruceKey: UInt8 = 1
    
    var source: TableDataSource? {
        get { objc_getAssociatedObject(self, &Self.dataSoruceKey) as? TableDataSource }
        set { objc_setAssociatedObject(self, &Self.dataSoruceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func reloadData(_ dataSource: TableDataSource) {
        self.source = dataSource
        self.dataSource = self.source
        //self.delegate = self.source
        
        self.reloadData()
    }
}


