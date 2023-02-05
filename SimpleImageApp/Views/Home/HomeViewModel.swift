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
    
    init(service: ImageServiceInterface) {
        self.service = service
    }
    
    struct Input {
        let loadNextPage: Driver<Bool>
    }
    struct Output {
        let section: Driver<[TableSection]>
        let navigation: Driver<Navigation>
    }
    
    func transform(_ input: Input) -> Output {
        
        let initial = Observable<Void>.just(())
            .observe(on: SerialDispatchQueueScheduler(qos: .userInitiated))
            .flatMap { [weak self] _ in
                guard let self = self else {
                    return Observable<PixabayImageResult>.error(ObjectError.outOfMemory)
                }
                
                return self.service.searchImages(query: "", limit: 20, page: 1)
            }
            .compactMap { [weak self] result in
                self?.parseDataIntoSectionData(result: result)
            }
            .asDriver(onErrorJustReturn: [])
        
        let navigation: Driver<Navigation> = selectedImage
            .compactMap {
                guard let img = $0 else { return nil }
                return Navigation.toImage(image: img)
            }
            .asDriver(onErrorJustReturn: Navigation.none)
        
        return Output(section: initial, navigation: navigation)
    }
    
    
    private func parseDataIntoSectionData(result: PixabayImageResult) -> [TableSection] {
        guard let hits = result.hits, !hits.isEmpty else { return [] }
        let rows = hits.map { img in
            let model = ImageCellModel(img: img) {
                self.selectedImage.accept(img)
            }
            return TableRow<ImageCell>(model)
        }
        return [TableSection(rows: rows)]
    }
}

extension HomeViewModel {
    
    enum Navigation {
        case toImage(image: PixabayImage)
        case none
    }
    
}
