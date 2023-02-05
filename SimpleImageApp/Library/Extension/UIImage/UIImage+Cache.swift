//
//  UIImage+Cache.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import UIKit

//MARK: - ImageCacheProtocol
protocol ImageCacheProtocol {
    subscript(url: URL) -> UIImage? { get set }
}

//MARK: - ImageCache
class ImageCache {
    private lazy var cache: NSCache<NSURL, UIImage> = {
        let cache: NSCache<NSURL, UIImage> = .init()
        cache.totalCostLimit = 200_000_000
        return cache
    }()
    
    static var shared: ImageCache = .init()

}

extension ImageCache: ImageCacheProtocol {
    subscript(url: URL) -> UIImage? {
        get {
            cache.object(forKey: url as NSURL)
        }
        
        set {
            let nsURL = url as NSURL
            if let _ = cache.object(forKey: nsURL) {
                cache.removeObject(forKey: nsURL)
            }
            guard let validImg = newValue else { return }
            cache.setObject(validImg, forKey: nsURL)
        }
    }
}
