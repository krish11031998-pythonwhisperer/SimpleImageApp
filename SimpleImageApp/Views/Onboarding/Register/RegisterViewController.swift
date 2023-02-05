//
//  RegisterViewController.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import Foundation
import UIKit
import RxSwift
import RxCocoa

//MARK: - IsValid & IsEqual
struct TextFieldValidity {
    let isValid: Bool
    let isEqual: Bool
    
    init(isValid: Bool, isEqual: Bool) {
        self.isValid = isValid
        self.isEqual = isEqual
    }
}

extension TextFieldValidity: Equatable {
    
    static func == (lhs: TextFieldValidity, rhs: TextFieldValidity) -> Bool {
        return (lhs.isValid == rhs.isValid) && (lhs.isEqual == rhs.isEqual)
    }
}

class RegisterViewController: ViewController {
 
    private lazy var emailTextField: TextFieldView = { .init(type: .email()) }()
    private lazy var passwordTextField: TextFieldView = { .init(type: .password()) }()
    private lazy var ageTextField: TextFieldView = { .init(type: .age()) }()
    private lazy var confirmPasswordTextField: TextFieldView = { .init(type: .password(title: "Confirm Password")) }()
    private lazy var registerButton: CustomButton = { .init() }()
    private lazy var loginButton: CustomButton = { .init() }()
    private var bag: DisposeBag = .init()
    private let viewModel: RegisterViewModel
    
    init(_ viewModel: RegisterViewModel = .init()) {
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
        setupNavBar(title: "Register")
    }
    
    private func setupView() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        [.spacer(), registerButton].forEach(buttonStack.addArrangedSubview(_:))
        
        [emailTextField, passwordTextField, confirmPasswordTextField, ageTextField, registerButton, loginButton, .spacer()].forEach(stack.addArrangedSubview(_:))
        
        view.addSubview(stack)
        view.setFittingContraints(childView: stack, insets: .init(vertical: 100, horizontal: 16))
        view.backgroundColor = .surfaceBackground
        stack.setCustomSpacing(24, after: ageTextField)
        registerButton.setTitle("Register", for: .normal)
        loginButton.setTitle("Login", for: .normal)
        registerButton.isEnabled = false
    }
    
    private func bind() {
      
        Driver.combineLatest(isValid, isEqual) { TextFieldValidity(isValid: $0, isEqual: $1) }
            .distinctUntilChanged()
            .drive(enableRegisterButton)
            .disposed(by: bag)

        
        let registerModel = Driver.combineLatest(emailTextField.rx.text, passwordTextField.rx.text, ageTextField.rx.text) { RegisterModel(email: $0, password: $1, age: $2) }
        
        let register = registerButton.rx.controlEvent(.touchUpInside)
            .withLatestFrom(registerModel)
            .asDriver(onErrorJustReturn: .init(email: "", password: "", age: ""))
        
        let login = loginButton.rx.controlEvent(.touchUpInside)
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
        
        let output = viewModel.transform(.init(login: login, register: register))
        
        output.navigation
            .drive(navBinder)
            .disposed(by: bag)
    }
    
    private var isValid: Driver<Bool> {
        Driver.combineLatest(emailTextField.rx.isValid, passwordTextField.rx.isValid, confirmPasswordTextField.rx.isValid) { $0 && $1 && $2 }
            .distinctUntilChanged()
    }
    
    private var isEqual: Driver<Bool> {
        Driver.combineLatest(passwordTextField.rx.text, confirmPasswordTextField.rx.text) { $0 == $1 }
            .distinctUntilChanged()
    }
    
    private var enableRegisterButton: Binder<TextFieldValidity> {
        Binder(self) { host, validity in
            if validity.isValid && !validity.isEqual {
                host.confirmPasswordTextField.sendErrorMessage(message: "Passwords must be equal")
            } else if validity.isValid && validity.isEqual {
                host.confirmPasswordTextField.sendErrorMessage(message: nil)
            }
            
            host.registerButton.isEnabled = validity.isValid && validity.isEqual
        }
    }
    
    private var navBinder: Binder<OnboardingNavigation> {
        Binder(self) { host, nav in
            switch nav {
            case .login:
                host.pushTo(LoginViewController())
            case .home:
                host.pushTo(HomeViewController())
            case .err(let message):
                host.showErrorAlert(title: "Register Error", message: message)
            default:
                break
            }
        }
    }
}
