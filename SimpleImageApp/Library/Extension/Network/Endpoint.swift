//
//  Endpoint.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation
import RxSwift

protocol EndPoint {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem] { get }
    var body: Data? { get }
    var request: URLRequest? { get }
    var header: [String : String]? { get }
    func execute<T: Codable>() ->  Observable<T>
}


extension EndPoint {
    var request: URLRequest? {
        var uC = URLComponents()
        uC.scheme = scheme
        uC.host = baseUrl
        uC.path = path
        uC.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = uC.url  else {
            return nil
        }
        
        var request: URLRequest = .init(url: url)
        request.allHTTPHeaderFields = header
        request.httpBody = body
        request.httpMethod = method
        return request
    }
    
    
    func execute<T: Codable>() -> Observable<T> {
        guard let request = self.request else {
            return Observable<T>.error(URLSessionError.invalidURL)
        }
        return request.execute()
    }
}

