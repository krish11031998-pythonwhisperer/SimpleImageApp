//
//  ViewModel.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output
}
