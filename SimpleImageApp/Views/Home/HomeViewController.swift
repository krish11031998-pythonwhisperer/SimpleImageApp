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
    private lazy var logoutButton: UIButton = { .init() }()
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
        mainNavBar(title: "Pixabay Images")
        setupLogoutButton()
        view.backgroundColor = .surfaceBackground
        bind()
    }
    
    private func bind() {
                
        let nextPage = tableView.rx.loadNextPage
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        let logout = logoutButton.rx.controlEvent(.touchUpInside)
            .map { _ in ()}
            .asDriver(onErrorJustReturn: ())
        
        let input = HomeViewModel.Input(loadNextPage: nextPage, logout: logout)
        
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
                    self?.pushTo(ImageDetailViewController(viewModel: .init(selectedImage: image)))
                case .onboarding:
                    UserDefaultStoreKey.loggedIn.setValue(false)
                    self?.Onboarding()
                default:
                    break
                }
            }
            .disposed(by: bag)
    
        tableView.rx.didSelectItemDisposable.disposed(by: bag)
    }
    
    private func setupLogoutButton() {
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        navigationItem.rightBarButtonItem = .init(customView: logoutButton)
    }
    
    private func Onboarding() {
        guard let topMost = navigationController?.topViewController else { return }
        if topMost === self {
            let vc = OnboardingViewController()
            navigationController?.setViewControllers([vc], animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
