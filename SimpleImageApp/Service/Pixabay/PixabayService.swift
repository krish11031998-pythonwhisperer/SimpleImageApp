//
//  PixabayService.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import RxSwift

class PixabayService: ImageServiceInterface {
    func searchImages(query: String, limit: Int = 20, page: Int = 1) -> RxSwift.Observable<PixabayImageResult> {
        PixabayEndpoint
            .search(q: query, limit: limit, page: page)
            .execute()
    }
}
