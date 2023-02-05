//
//  TextFieldType.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit

enum TextFieldType {
    case email(title: String = "Email", placeholder: String = "john.doe@example.com")
    case password(title: String = "Password", placeholder: String = "")
    case age(title: String = "Age", placeholder: String = "")
}


extension TextFieldType {
    
    var secureText: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
    
    var validators: [TextValidationInterface] {
        switch self {
        case .email:
            return [EmailValidator()]
        case .password:
            return [TwelveCharactersLong()]
        default:
            return []
        }
    }
    
    var placeHolder: String {
        switch self {
        case .email(let title, _), .password(let title, _), .age(let title, _):
            return title
        }
    }
    
}
