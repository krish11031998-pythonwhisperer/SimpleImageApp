//
//  TextFieldView.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 04/02/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TextFieldView: UIView {
    
    @IBOutlet weak var textFeild: TextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: TextFieldInfoLabel!
    @IBOutlet weak var stack: UIStackView!
    private var bag: DisposeBag = .init()
    private let type: TextFieldType
    
    init(type: TextFieldType = .email()) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.type = .email()
        super.init(coder: coder)
        setupView()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib(nibName: Self.name) else { return }
        addSubview(view)
        setFittingContraints(childView: view, insets: .zero)
    }
    
    private func setupView() {
        commonInit()
        titleLabel.text = type.placeHolder
        infoLabel.text = "info"
        infoLabel.isHidden = true
        infoLabel.textColor = .red
        infoLabel.font = .systemFont(ofSize: 12, weight: .medium)
        stack.spacing = 8
        stack.setCustomSpacing(8, after: textFeild)
        textFeild.configure(with: type)
        bind()
    }
    
    private func bind() {
        textFeild.rx.errorText
            .drive(errText)
            .disposed(by: bag)
        
        textFeild.rx.isValid
            .distinctUntilChanged()
            .filter { $0 }
            .drive(clearErrText)
            .disposed(by: bag)
    }
    
    private var errText: Binder<String?> {
        Binder(self) { host, text in
            host.infoLabel.text = text
        }
    }
    
    private var clearErrText: Binder<Bool> {
        Binder(self) { host, _ in
            host.infoLabel.text = nil
        }
    }
    
    func sendErrorMessage(message: String?) {
        infoLabel.text = message
    }
    
    func configureType(type: TextFieldType) {
        textFeild.configure(with: type)
        titleLabel.text = type.placeHolder
    }
}

extension Reactive where Base == TextFieldView {
    
    var isValid: Driver<Bool> {
        base.textFeild.rx.isValid
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
    }

    var text: Driver<String> {
        base.textFeild.rx.text
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: "")
    }
    
    var textEdittingDone: Driver<Bool> {
        base.textFeild.rx.edittingEnded.asDriver(onErrorJustReturn: false)
    }
    
}
