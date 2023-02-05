//
//  NewOnboardingViewController.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingViewController: ViewController {
    
    private let viewModel: OnboardingViewModel
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var subHeadline: UILabel!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var registerButton: CustomButton!
    @IBOutlet weak var mainStack: UIStackView!
    
    private var bag: DisposeBag = .init()
    init() {
        self.viewModel = .init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    private func bind() {
        
        let loginButtonTapped = loginButton.rx.controlEvent(.touchUpInside).map { _ in ()}.asDriver(onErrorJustReturn: ())
        
        let registerButtonTapped = registerButton.rx.controlEvent(.touchUpInside).map { _ in ()}.asDriver(onErrorJustReturn: ())
        
        
        let input = OnboardingViewModel.Input(login: loginButtonTapped, register: registerButtonTapped)
        
        let output = viewModel.transform(input)
        
        output.navigation
            .drive { [weak self] nav in
                switch nav {
                case .login:
                    self?.navigationController?.pushViewController(LoginViewController(viewModel: .init()), animated: true)
                case .register:
                    self?.navigationController?.pushViewController(RegisterViewController(), animated: true)
                default:
                    break
                }
            }
            .disposed(by: bag)
    }
    
    private func setupView() {
        mainStack.setCustomSpacing(24, after: subHeadline)
        loginButton.setTitle("Login", for: .normal)
        registerButton.setTitle("Register", for: .normal)
    }

}
