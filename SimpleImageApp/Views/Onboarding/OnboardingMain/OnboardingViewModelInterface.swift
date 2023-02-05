//
//  FormViewModel.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class OnboardingViewModel {

    struct Input {
        let login: Driver<()>
        let register: Driver<()>
    }
    
    struct Output {
        let navigation: Driver<OnboardingNavigation>
    }
    
    func transform(_ input: Input) -> Output {
        
        let loginNav = input.login.map { _ in OnboardingNavigation.login }
        let registerNav = input.register.map { _ in OnboardingNavigation.register }
        
        let navigation = Driver.merge([loginNav, registerNav])
        
        return .init(navigation: navigation)
    }
}
