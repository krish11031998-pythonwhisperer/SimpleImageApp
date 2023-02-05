//
//  URLRequest.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import RxSwift

enum URLSessionError: String, Error {
    case invalidURL
    case invalidData
    case decodeError
}


extension URLRequest {
    
    func execute<T: Codable>() -> Observable<T> {
        print("(REQUEST) URL: ", self.url?.absoluteURL)
        return Observable.create { observable in
            let session = URLSession.shared.dataTask(with: self) { data, resp, err in
                guard let validData = data else {
                    observable.onError(err ?? URLSessionError.invalidData)
                    return
                }
                
                guard let decodedData = try? JSONDecoder().decode(T.self, from: validData) else {
                    observable.onError(URLSessionError.decodeError)
                    return
                }
                
                observable.onNext(decodedData)
            }
            
            session.resume()
            
            return Disposables.create()
        }
    }
    
}

