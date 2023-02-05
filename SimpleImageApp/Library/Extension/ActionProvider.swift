//
//  ActionProvider.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation

typealias Callback = () -> Void

protocol ActionProvider {
    var action: Callback? { get set }
}
