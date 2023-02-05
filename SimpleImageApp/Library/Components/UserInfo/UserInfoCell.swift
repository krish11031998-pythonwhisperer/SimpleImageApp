//
//  UserInfoTableViewCell.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 05/02/2023.
//

import UIKit
import RxSwift
struct UserInfoCellModel {
    let userName: String
    let userImgUrl: String
    let userId: String
}

class UserInfoCell: ConfigurableCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userId: UILabel!
    private var bag: DisposeBag = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        userImage.setupAsStandardImage(cornerRadius: 30)
        titleLabel.font = .preferredFont(forTextStyle: .caption1)
        userName.font = .preferredFont(forTextStyle: .body)
        userId.font = .preferredFont(forTextStyle: .footnote)
        userId.textColor = .gray
        selectionStyle = .none
        backgroundColor = .surfaceBackground
        titleLabel.text = "Uploaded By"
    }
    
    func configure(with model: UserInfoCellModel) {
        userName.text = model.userName
        userId.text = model.userId
        userImage.loadImage(forURL: model.userImgUrl).disposed(by: bag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
    }
}
