//
//  NewImageDetailViewController.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import UIKit
import RxCocoa
import RxSwift

class ImageDetailViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
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
        setupNavBar()
        setupView()
        bind()
    }
    
    private func setupView() {
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.sectionHeaderHeight = UITableView.automaticDimension
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
