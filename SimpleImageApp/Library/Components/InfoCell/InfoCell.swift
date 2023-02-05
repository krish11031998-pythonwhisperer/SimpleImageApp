//
//  InfoCell.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

struct InfoCellModel {
    let title: String
    let description: String
}

class InfoCell: ConfigurableCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stack: UIStackView!
    private func setupView() {
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = .init(vertical: 20, horizontal: 12)
        stack.backgroundColor = .surfaceBackground
        stack.cornerRadius = 16
        stack.applyShadow()
        selectionStyle = .none
        backgroundColor = .surfaceBackground
    }
    
    func configure(with model: InfoCellModel) {
        setupView()
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
