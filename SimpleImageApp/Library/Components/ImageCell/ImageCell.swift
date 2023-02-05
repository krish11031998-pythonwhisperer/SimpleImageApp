//
//  ImageCell.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit
import RxSwift

extension PixabayImage {
    var previewAspectRatio: CGFloat { webformatWidth/webformatHeight }
}

//MARK: - ImageCellModel
struct ImageCellModel: ActionProvider {
    let img: PixabayImage
    var action: Callback?
}

//MARK: - ImageCell
class ImageCell: ConfigurableCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    private var bag: DisposeBag = .init()
    
    private func setupView() {
        userImage.setupAsStandardImage(cornerRadius: 20)
        imgView.setupAsStandardImage(cornerRadius: 16)
        userName.font = .systemFont(ofSize: 14, weight: .medium)
        selectionStyle = .none
        contentView.backgroundColor = .surfaceBackground
    }
    
    func configure(with model: ImageCellModel) {
        setupView()
        let imgModel = model.img
        imgView.loadImage(forURL: imgModel.webformatURL).disposed(by: bag)
        userImage.loadImage(forURL: imgModel.userImageURL).disposed(by: bag)
        userName.text = imgModel.user
        heightConstraint.constant = (UIScreen.main.bounds.width - 32)/imgModel.previewAspectRatio
    }
    
}
