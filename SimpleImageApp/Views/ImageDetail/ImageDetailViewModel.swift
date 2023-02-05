//
//  ImageDetailViewModel.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import RxSwift
import RxCocoa

class ImageDetailViewModel {
    
    private let selectedImage: PixabayImage
    
    init(selectedImage: PixabayImage) {
        self.selectedImage = selectedImage
    }
    
    struct Output {
        let sections: Driver<[TableSection]>
    }
    
    func transform() -> Output {
        
        let initialLoad: Driver<[TableSection]> = Observable.just(selectedImage)
            .compactMap { [weak self] in self?.mapImageToTableData(img: $0) }
            .asDriver(onErrorJustReturn: [])
        
        return Output(sections: initialLoad)
    }
    
    
    private func mapImageToTableData(img: PixabayImage) -> [TableSection] {
        return [imageInfoSection(), userInfo()]
    }
    
    private func imageInfoSection() -> TableSection {
        
        let imgView = TableRow<LargeImageCell>(selectedImage)
        let imgSize = TableRow<InfoCell>(.init(title: "Size", description: String(format: "%.0f", selectedImage.imageSize)))
        let imgType = TableRow<InfoCell>(.init(title: "Type", description: selectedImage.type))
        let imgTags = TableRow<InfoCell>(.init(title: "Tags", description: selectedImage.tags))
        
        return .init(rows: [imgView, imgSize, imgType, imgTags], heading: "Image")
    }
    
    private func userInfo() -> TableSection {
        let user = TableRow<UserInfoCell>(UserInfoCellModel(userName: selectedImage.user, userImgUrl: selectedImage.userImageURL, userId: String(format: "%.0f", selectedImage.userId)))
        let likes = TableRow<InfoCell>(.init(title: "Likes", description: "\(selectedImage.likes)"))
        let comments = TableRow<InfoCell>(.init(title: "Comments", description: "\(selectedImage.comments)"))
        let views = TableRow<InfoCell>(.init(title: "Views", description: String(format: "%.0f", selectedImage.views)))
        let favorites = TableRow<InfoCell>(.init(title: "Favorites", description: "\(selectedImage.collections)"))
        let downloads = TableRow<InfoCell>(.init(title: "Downloads", description: "\(selectedImage.downloads)"))
        
        return .init(rows: [user, likes, comments, views, favorites, downloads], heading: "Image Details")
    }
}
