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
            return [AgeValidator()]
        }
    }
    
    var placeHolder: String {
        switch self {
        case .email(let title, _), .password(let title, _), .age(let title, _):
            return title
        }
    }
    
    var rightSideView: UIView? {
        switch self {
        case .password:
            let button = UIButton()
            button.setImage(SFSymbolCatalogue.eye.image, for: .normal)
            button.setImage(SFSymbolCatalogue.eyeSlash.image, for: .selected)
            
            return button
        default:
            return nil
        }
    }
    
    var rightSideViewMode: UITextField.ViewMode {
        switch self {
        case .password:
            return .always
        default:
            return .never
        }
    }
    
}
