//
//  ViewController.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import UIKit
import RxSwift

class HomeViewController: ViewController {

    private lazy var tableView: UITableView = { .standardTableView() }()
    private let viewModel: HomeViewModel
    private var bag: DisposeBag = .init()
    //MARK: - Overriden Methods
    
    init(viewModel: HomeViewModel = .init(service: PixabayService())) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        bind()
    }
    
    
    //MARK: - Protected Methods
    private func setupView() {
        view.addSubview(tableView)
        view.setFittingContraints(childView: tableView, insets: .zero)
        view.backgroundColor = .surfaceBackground
        tableView.backgroundColor = .surfaceBackground
        mainNavBar(title: "Pixabay Images")
    }

    
    private func bind() {
        
        tableView.rx.contentOffset
                   .map { $0.y }
                   .bind(onNext: { print($0) })
                   .disposed(by: bag)
        
        let nextPage = tableView.rx.loadNextPage
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        let input = HomeViewModel.Input(loadNextPage: nextPage)
        
        let output = viewModel.transform(input)
        
        output.section
            .drive { [weak self] sections in
                self?.tableView.reloadData(.init(sections: sections))
            }
            .disposed(by: bag)
        
        output
            .navigation
            .drive { [weak self] nav in
                switch nav {
                case .toImage(let image):
                    print("(DEBUG) SelectedImage: ", image.id)
                    self?.navigationController?.pushViewController(ImageDetailController(viewModel: .init(selectedImage: image)), animated: true)
                default:
                    break
                }
            }
            .disposed(by: bag)
    
        tableView.rx.didSelectItemDisposable.disposed(by: bag)
        
        tableView.rx.loadNextPage
            .distinctUntilChanged()
            .subscribe(onNext: { print("(DEBUG) Load Next Page: ", $0) })
            .disposed(by: bag)
        
    }
    
    private var scrollBinder: Binder<CGPoint> {
        Binder(self) { host, offset in
            print("(DEBUG) offset (via Binder): ", offset)
        }
    }
}
