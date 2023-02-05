//
//  PixabayServiceProtocol.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import RxSwift

protocol ImageServiceInterface {
    func searchImages(query: String, limit: Int, page: Int) -> Observable<PixabayImageResult>
}
