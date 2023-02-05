//
//  PixabayEndpoints.swift
//  SimpleImageApp
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation

//MARK: - PixabayEndpoint
enum PixabayEndpoint {
    case search(q: String, limit: Int, page: Int)
}

//MARK: - PixabayEndpoint + APIKey
fileprivate extension PixabayEndpoint {
    var apiKey: String { "33348431-f443aba5724cb55c199b68349" }
}

//MARK: - PixabayEndpoint + Endpoint
extension PixabayEndpoint: EndPoint {
    
    var scheme: String {
        return "https"
    }
    
    var baseUrl: String {
        return "pixabay.com"
    }
    
    var path: String {
        switch self {
        case .search:
            return "/api/"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let q, let limit, let page):
            return [
                .init(name: "q", value: q),
                .init(name: "per_page", value: "\(limit)"),
                .init(name: "page", value: "\(page)"),
                .init(name: "key", value: apiKey)
            ].filter { $0.value != nil && $0.value != "" }
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: Data? {
        nil
    }
}
