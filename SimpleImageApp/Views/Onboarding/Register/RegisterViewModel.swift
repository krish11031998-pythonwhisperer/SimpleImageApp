//
//  RegisterViewModel.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel {
    
    private let registerService: RegisterServiceInterface
    
    init(registerService: RegisterServiceInterface = RegisterService()) {
        self.registerService = registerService
    }
    
    struct Input {
        let login: Driver<()>
        let register: Driver<RegisterModel>
    }
    
    
    struct Output {
        let navigation: Driver<OnboardingNavigation>
    }
    
    func transform(_ input: Input) -> Output {
        
        let register = input.register
            .flatMap { [weak self] model -> Driver<OnboardingNavigation> in
                guard let self else {
                    return Observable.just(OnboardingNavigation.err(message: "Object out of memory"))
                            .asDriver(onErrorJustReturn: .err(message: "Error"))
                }
                return self.registerService.register(email: model.email, password: model.password, age: Int(model.age) ?? 0)
                    .map { state -> OnboardingNavigation in
                        if state {
                            return OnboardingNavigation.home
                        } else {
                            return OnboardingNavigation.err(message: "Register Fail")
                        }
                    }
                    .asDriver { error in Driver.just(OnboardingNavigation.err(message: error.localizedDescription)) }
            }
        
        let login = input.login.map { _ in OnboardingNavigation.login }
        
        let nav = Driver.merge([register, login])
        
        return .init(navigation: nav)
            
    }
}
