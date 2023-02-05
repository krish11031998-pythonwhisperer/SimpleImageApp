//
//  OnboardingVIewController.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class OnboardingVIewController: UIViewController {
    
    private let viewModel: OnboardingViewModel
    private lazy var loginButton: CustomButton = { .init() }()
    private lazy var registerButton: CustomButton = { .init() }()
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
                }
            }
            .disposed(by: bag)
    }
    
    private func setupView() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        
        let buttonStack: UIStackView = .init()
        buttonStack.spacing = 8
        buttonStack.distribution = .fillEqually
        
        loginButton.setTitle("Login", for: .normal)
        registerButton.setTitle("Register", for: .normal)
        
        [loginButton, registerButton].forEach(buttonStack.addArrangedSubview(_:))
        
        view.addSubview(buttonStack)
        view.setFittingContraints(childView: buttonStack, leading: 16, trailing: 16, centerX: 0, centerY: 0)
        view.backgroundColor = .surfaceBackground
    }
}
