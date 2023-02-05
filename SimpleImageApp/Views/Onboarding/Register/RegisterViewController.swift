//
//  NewRegisterViewController.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import UIKit
import RxCocoa
import RxSwift

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
    
    @IBOutlet weak var emailTextField: TextFieldView!
    @IBOutlet weak var passwordTextField: TextFieldView!
    @IBOutlet weak var ageTextField: TextFieldView!
    @IBOutlet weak var confirmPasswordTextField: TextFieldView!
    @IBOutlet weak var registerButton: CustomButton!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var stack: UIStackView!
    
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
        stack.addArrangedSubview(.spacer())
        stack.setCustomSpacing(24, after: ageTextField)
        
        passwordTextField.configureType(type: .password())
        confirmPasswordTextField.configureType(type: .password(title: "Confirm Password"))
        ageTextField.configureType(type: .age())
        
        registerButton.setTitle("Register", for: .normal)
        loginButton.setTitle("Already a user? Login", for: .normal)
        registerButton.isEnabled = false
    }
    
    private func bind() {
        
        Driver.combineLatest(isValid, isEqual) { TextFieldValidity(isValid: $0, isEqual: $1) }
        //.distinctUntilChanged()
            .drive(enableRegisterButton)
            .disposed(by: bag)
        
        textFieldCheck
            .drive(confirmPasswordMessage)
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
        Driver.combineLatest(emailTextField.rx.isValid, passwordTextField.rx.isValid, confirmPasswordTextField.rx.isValid, ageTextField.rx.isValid) { $0 && $1 && $2 && $3 }
            .distinctUntilChanged()
    }
    
    private var isEqual: Driver<Bool> {
        Driver.combineLatest(passwordTextField.rx.text,
                             confirmPasswordTextField.rx.text) { $0 == $1 }
            .distinctUntilChanged()
    }
    
    private var textFieldCheck: Driver<Bool> {
        passwordTextField.rx.textEdittingDone
            .withLatestFrom(isEqual)
    }
    
    
    private var enableRegisterButton: Binder<TextFieldValidity> {
        Binder(self) { host, validity in
            host.registerButton.isEnabled = validity.isValid && validity.isEqual
        }
    }
    
    private var confirmPasswordMessage: Binder<Bool> {
        Binder(self) { host, isEqual in
            if isEqual {
                host.confirmPasswordTextField.sendErrorMessage(message: nil)
            } else {
                host.confirmPasswordTextField.sendErrorMessage(message: "Passwords must match")
            }
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
