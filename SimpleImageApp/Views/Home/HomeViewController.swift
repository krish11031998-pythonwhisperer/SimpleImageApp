//
//  NewHomeViewController.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
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
        setupNavBar(title: "Pixabay Images")
        view.backgroundColor = .surfaceBackground
        bind()
    }
    
    private func bind() {
                
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
                    self?.navigationController?.pushViewController(ImageDetailViewController(viewModel: .init(selectedImage: image)), animated: true)
                default:
                    break
                }
            }
            .disposed(by: bag)
    
        tableView.rx.didSelectItemDisposable.disposed(by: bag)
    }
}
