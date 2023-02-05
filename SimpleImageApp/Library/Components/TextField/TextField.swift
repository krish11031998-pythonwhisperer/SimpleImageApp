//
//  TextField.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TextField: UITextField {
    
    private(set) var type: TextFieldType
    
    //MARK: - Overriden Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 7.5, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 7.5, dy: 10)
    }
    
    //MARK: - Configure
    
    init(type: TextFieldType) {
        self.type = type
        super.init(frame: .zero)
        setupTextField()
    }

    required init?(coder: NSCoder) {
        self.type = .password()
        super.init(coder: coder)
        setupTextField()
    }
    
    
    private func setupTextField() {
        border()
//        layer.borderColor = UIColor.surfaceBackgroundInverse.cgColor
//        layer.borderWidth = 2
//        cornerRadius = 12
        placeholder = type.placeHolder
        font = .systemFont(ofSize: 14, weight: .medium)
        clearsOnInsertion = false
        clearsOnBeginEditing = false
        autocorrectionType = .no
        autocapitalizationType = .none
        isSecureTextEntry = type.secureText
        setFrame(height: 50)
        layer.masksToBounds = true
    }

    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.surfaceBackgroundInverse.cgColor
    }
    
    func configure(with type: TextFieldType) {
        self.type = type
        self.setupTextField()
    }
    
}

//MARK: - TextField + Observables
extension Reactive where Base == TextField {
    
    var isValid: Observable<Bool> {
        base.rx.controlEvent(.editingChanged)
            .withUnretained(base)
            .map { _ in
                guard let text = base.text else { return false }
                return base.type.validators.map { $0.isValid(with: text) }.reduce(true, { $0 && $1} )
            }
            .asObservable()
    }
    
    var edittingEnded: Observable<Bool> {
        base.rx.controlEvent(.editingDidEnd)
            .withUnretained(base)
            .map { _ in true }
            .asObservable()
    }
}
