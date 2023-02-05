//
//  RegisterService.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import Foundation
import RxSwift

enum RegisterError: String, Error {
    case emptyEmailPasswordOrAge = "Empty Email and/or Password and/or Age.\n Please enter valid email and/or password and/or age"
    case userAge = "Users must be aged between 18 to 99"
}

extension RegisterError: LocalizedError {
    public var errorDescription: String? {
        NSLocalizedString(self.rawValue, comment: "LoginError")
    }
}

class RegisterService: RegisterServiceInterface {
    func register(email: String, password: String, age: Int) -> Observable<Bool> {
        Observable.create { observable in
            
            guard !email.isEmpty, !password.isEmpty else {
                observable.onError(RegisterError.emptyEmailPasswordOrAge)
                return Disposables.create()
            }
            
            if 18...99 ~= age {
                UserDefaultStoreKey.email.setValue(email)
                UserDefaultStoreKey.password.setValue(password)
                UserDefaultStoreKey.loggedIn.setValue(true)
                observable.onNext(true)
            } else {
                observable.onError(RegisterError.userAge)
            }
            
            
            return Disposables.create()
        }
    }
}
