//
//  LoginServiceInterface.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import RxSwift

protocol LoginServiceInterface {
    
    func loginUser(username: String, password: String) ->  Observable<Bool>
}
