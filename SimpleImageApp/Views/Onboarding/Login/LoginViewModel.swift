//
//  LoginViewModel.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    private let loginService: LoginServiceInterface
    
    init(loginService: LoginServiceInterface = LoginService()) {
        self.loginService = loginService
    }
    
    struct Input {
        let register: Driver<()>
        let login: Driver<LoginModel>
    }
    
    struct Output {
        let navigation: Driver<OnboardingNavigation>
    }
    
    func transform(_ input: Input) -> Output {
        
        let login = input.login
            .flatMap { [weak self] model -> Driver<OnboardingNavigation> in
                guard let self else {
                    return Observable.just(OnboardingNavigation.err(message: "Object out of memory"))
                            .asDriver(onErrorJustReturn: .err(message: "Error"))
                }
                return self.loginService.loginUser(username: model.username, password: model.password)
                    .map { state -> OnboardingNavigation in
                        if state {
                            return OnboardingNavigation.home
                        } else {
                            return OnboardingNavigation.err(message: "Login Fail")
                        }
                    }
                    .asDriver { error in Driver.just(OnboardingNavigation.err(message: error.localizedDescription)) }
            }
            
        
        let register = input.register.map { _ in OnboardingNavigation.register }
        
        let nav = Driver.merge([login, register])
        
        return .init(navigation: nav)
        
    }
}
