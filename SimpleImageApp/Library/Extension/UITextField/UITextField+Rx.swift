//
//  UITextField.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    
    var finishedEditting: Driver<Bool> {
        let end = base.rx.controlEvent(.editingDidEnd).asObservable()
        let endOnExit = base.rx.controlEvent(.editingDidEndOnExit).asObservable()
        
        return Observable.merge([end, endOnExit]).map { _ in true }.asDriver(onErrorJustReturn: false)
    }
    
}
