//
//  ImageDetail.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit
import RxSwift

class ImageDetailController: ViewController {
    
    private lazy var tableView: UITableView = { .standardTableView() }()
    private let viewModel: ImageDetailViewModel
    private var bag: DisposeBag = .init()
    
    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        bind()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        view.setFittingContraints(childView: tableView, insets: .zero)
        tableView.backgroundColor = .surfaceBackground
    }
    
    private func bind() {
        let output = viewModel.transform()
        
        output.sections
            .drive { [weak self] sections in
                self?.tableView.reloadData(.init(sections: sections))
            }
            .disposed(by: bag)
    }
    
}
