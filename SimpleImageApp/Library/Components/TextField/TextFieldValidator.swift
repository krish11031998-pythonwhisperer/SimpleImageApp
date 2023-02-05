//
//  TextFieldValidator.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation

//MARK: - TextValidationInterface
protocol TextValidationInterface {
    var regex: String { get }
    func isValid(with value: String) -> Bool
    var text: String { get }
}

extension TextValidationInterface {
    func isValid(with value: String) -> Bool { value.isValidWith(regex: regex) }
}

//MARK: - EmailValidator
struct EmailValidator:TextValidationInterface {
    var text: String { "Please enter a valid emailId" }
    var regex: String {
        get { "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" }
    }
}
//MARK: - PasswordLengthValidator
struct TwelveCharactersLong: TextValidationInterface {    
    var text: String { "Must at least be between 6 and 12 characters long" }
    var regex: String { "^.{6,12}$" }
}
