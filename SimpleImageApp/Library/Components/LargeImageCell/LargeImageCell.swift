//
//  LargeImageCell.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit
import RxSwift

class LargeImageCell: ConfigurableCell {
    
    @IBOutlet weak private var imgView: UIImageView!
    @IBOutlet weak private var heightConstraint: NSLayoutConstraint!
    private var bag: DisposeBag = .init()
    private var image: PixabayImage?
    
    private func setupView() {
        imgView.setupAsStandardImage(cornerRadius: 16)
        backgroundColor = .surfaceBackground
        selectionStyle = .none
    }
    
    private func updateHeight() {
        guard let validImage = image else { return }
        let aspectRatio = validImage.imageWidth/validImage.imageHeight
        let height: CGFloat = (UIScreen.main.bounds.width - 32)/aspectRatio
        self.heightConstraint.constant = height
        contentView.applyShadow(color: .surfaceBackgroundInverse, radius: 10, opacity: 0.35, offset: .zero)
    }
    
    func configure(with model: PixabayImage) {
        setupView()
        imgView.loadImage(forURL: model.webformatURL).disposed(by: bag)
        image = model
        updateHeight()
    }
    
}
