//
//  NewLoginViewController.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: ViewController {

    @IBOutlet weak var emailTextField: TextFieldView!
    @IBOutlet weak var passwordTextField: TextFieldView!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var registerButton: CustomButton!
    @IBOutlet weak var stack: UIStackView!
    
    private let viewModel: LoginViewModel
    private var bag: DisposeBag = .init()
    
    init(viewModel: LoginViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = .init()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupView()
        setupNavBar(title: "Login")
    }
    
    private func setupView() {
        stack.addArrangedSubview(.spacer())
        stack.setCustomSpacing(24, after: passwordTextField)
        passwordTextField.configureType(type: .password())
        loginButton.setTitle("Login Into the App", for: .normal)
        loginButton.isEnabled = false
        
        registerButton.setTitle("New User? Register", for: .normal)
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
