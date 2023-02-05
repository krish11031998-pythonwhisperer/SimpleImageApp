//
//  LoginService.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import RxSwift

enum LoginError: String, Error {
    case emptyEmailOrPassword = "Empty Email and/or Password.\n Please enter valid email and/or password"
    case incorrectEmailOrPassword = "Incorrect Email and/or Password.\n Please enter valid email and/or password"
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        NSLocalizedString(self.rawValue, comment: "LoginError")
    }
}

class LoginService: LoginServiceInterface {
    
    func loginUser(username: String, password: String) -> Observable<Bool> {
        Observable.create { observable in
            guard !username.isEmpty, !password.isEmpty else {
                observable.onError(LoginError.emptyEmailOrPassword)
                return Disposables.create()
            }
            
            if username == "krish.fabre@gmail.com" && password == "LeoMessi1010" {
                observable.onNext(true)
            } else {
                observable.onError(LoginError.incorrectEmailOrPassword)
            }
            
            return Disposables.create()
        }
    }
}
