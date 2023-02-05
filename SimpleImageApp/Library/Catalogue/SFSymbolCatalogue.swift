//
//  SFSymbolCatalogue.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import Foundation
import UIKit

enum SFSymbolCatalogue: String {
    case eye = "eye"
    case eyeSlash = "eye.slash"
}


extension SFSymbolCatalogue {
    
    var image: UIImage? { .init(systemName: self.rawValue)?.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal) }
}
