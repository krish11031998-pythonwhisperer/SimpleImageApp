//
//  UIImage.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import RxSwift

extension UIImage {
    
    static func loadFromURL(forUrl url: URL) -> Observable<UIImage> {
        
        return Observable.create { observable in
            let request = URLRequest(url: url)
            
            let session = URLSession.shared.dataTask(with: request) { data, response, err in
                guard let validData = data else {
                    observable.onError(URLSessionError.invalidData)
                    return
                }
                
                guard let validImg = UIImage(data: validData) else {
                    observable.onError(URLSessionError.decodeError)
                    return
                }
                
                //TODO: - Add to Cache
                ImageCache.shared[url] = validImg
                observable.onNext(validImg)
            }
            
            session.resume()
            
            return Disposables.create()
        }
        
    }
    
    
    static func load(forUrl urlStr: String) -> Observable<UIImage> {
        guard let url = URL(string: urlStr) else {
            return Observable.just(UIImage())
        }
        
        if let validImage = ImageCache.shared[url] {
            return Observable.just(validImage)
        } else {
            return loadFromURL(forUrl: url)
        }
    }
    
}
