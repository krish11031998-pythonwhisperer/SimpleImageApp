//
//  HomeViewModel.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum ObjectError: String, Error {
    case outOfMemory
}

class HomeViewModel: ViewModel {
    
    private let service: ImageServiceInterface
    private let selectedImage: BehaviorRelay<PixabayImage?> = .init(value: nil)
    private var page: Int = 1
    private var images: [PixabayImage] = []
    init(service: ImageServiceInterface) {
        self.service = service
    }
    
    struct Input {
        let loadNextPage: Driver<Bool>
        let logout: Driver<()>
    }
    struct Output {
        let section: Driver<[TableSection]>
        let navigation: Driver<Navigation>
    }
    
    func transform(_ input: Input) -> Output {
        
        let initial = input.loadNextPage
            .asObservable()
            .observe(on: SerialDispatchQueueScheduler(qos: .userInteractive))
            .flatMapLatest { [weak self] _ in
                guard let self = self else {
                    return Observable<PixabayImageResult>.error(ObjectError.outOfMemory)
                }
                
                return self.service.searchImages(query: "", limit: Constants.limit, page: self.page)
            }
            .compactMap { [weak self] result in
                self?.parseDataIntoSectionData(result: result)
            }
            .asDriver(onErrorJustReturn: [])
        
        let image: Driver<Navigation> = selectedImage
            .compactMap {
                guard let img = $0 else { return nil }
                return Navigation.toImage(image: img)
            }
            .asDriver(onErrorJustReturn: Navigation.none)
        let logout = input.logout.map { _ in Navigation.onboarding }
        
        let nav = Driver.merge([image, logout])
        
        return Output(section: initial, navigation: nav)
    }
    
    
    private func parseDataIntoSectionData(result: PixabayImageResult) -> [TableSection]? {
        guard let hits = result.hits, !hits.isEmpty else { return nil }
        images.append(contentsOf: hits)
        let rows = images.map { img in
            let model = ImageCellModel(img: img) {
                self.selectedImage.accept(img)
            }
            return TableRow<ImageCell>(model)
        }
        page += 1
        return [TableSection(rows: rows)]
    }
}

extension HomeViewModel {
    
    enum Navigation {
        case toImage(image: PixabayImage)
        case onboarding
        case none
    }
    
    enum Constants {
        static let limit: Int = 100
    }
}
