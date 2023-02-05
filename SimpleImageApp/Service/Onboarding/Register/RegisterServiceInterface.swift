//
//  RegisterServiceInterface.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import Foundation
import RxSwift

protocol RegisterServiceInterface {
    func register(email: String, password: String, age: Int) -> Observable<Bool>
}
