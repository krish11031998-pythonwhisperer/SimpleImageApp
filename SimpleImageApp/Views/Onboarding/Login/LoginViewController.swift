//
//  LoginViewModel.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: ViewController {
 
    private lazy var emailTextField: TextFieldView = { .init(type: .email()) }()
    private lazy var passwordTextField: TextFieldView = { .init(type: .password()) }()
    private lazy var loginButton: CustomButton = { .init() }()
    private lazy var registerButton: CustomButton = { .init() }()
    private let viewModel: LoginViewModel
    private var bag: DisposeBag = .init()
    
    init(viewModel: LoginViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
        setupNavBar(title: "Login")
    }
    
    private func setupView() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        
        
        [emailTextField, passwordTextField, loginButton, registerButton, .spacer()].forEach(stack.addArrangedSubview(_:))
        
        view.addSubview(stack)
        view.setFittingContraints(childView: stack, insets: .init(vertical: 100, horizontal: 16))
        view.backgroundColor = .surfaceBackground
        stack.setCustomSpacing(24, after: passwordTextField)
        loginButton.setTitle("Login Into the App", for: .normal)
        loginButton.isEnabled = false
        
        registerButton.setTitle("Register", for: .normal)
    
    }
    
    private func bind() {
        
        Driver.combineLatest(emailTextField.rx.isValid, passwordTextField.rx.isValid) { $0 && $1 }
            .distinctUntilChanged()
            .drive { [weak self] in
                self?.loginButton.isEnabled = $0
            }
            .disposed(by: bag)

        let loginModel = Driver.combineLatest(emailTextField.rx.text, passwordTextField.rx.text) { LoginModel(username: $0, password: $1)}
        
        let login = loginButton.rx.controlEvent(.touchUpInside)
            .withLatestFrom(loginModel)
            .asDriver(onErrorJustReturn: .init(username: "", password: ""))
        
        let register = registerButton.rx.controlEvent(.touchUpInside)
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
    
            
        let output = viewModel.transform(.init(register: register, login: login))
        
        output.navigation
            .drive(navBinder)
            .disposed(by: bag)
    }
    
    
    private var navBinder: Binder<OnboardingNavigation> {
        Binder(self) { host, nav in
            switch nav {
            case .register:
                host.pushTo(RegisterViewController())
            case .home:
                host.pushTo(HomeViewController())
            case .err(let message):
                host.showErrorAlert(title: "Login Error", message: message)
            default:
                return
            }
        }
    }
}
