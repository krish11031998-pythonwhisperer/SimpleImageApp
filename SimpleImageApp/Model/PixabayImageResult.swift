//
//  PixabayImageResul.swift
//  VuzAssessment
//
//  Created by Krishna Venkatramani on 03/02/2023.
//

import Foundation

struct PixabayImageResult: Codable {
    let total: Double
    let totalHits: Int
    let hits: [PixabayImage]?
}


struct PixabayImage: Codable {
    let id: Double
    let pageURL: String
    let type: String
    let tags: String
    let previewURL: String
    let previewWidth: CGFloat
    let previewHeight: CGFloat
    let webformatURL: String
    let webformatWidth: CGFloat
    let webformatHeight: CGFloat
    let largeImageURL: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let imageSize: Double
    let views: Double
    let downloads: Double
    let collections: Int
    let likes: Int
    let comments: Int
    let userId: Double
    let user: String
    let userImageURL: String
    
    enum CodingKeys: String, CodingKey {
        
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL,
             imageWidth, imageHeight, imageSize, views, downloads, collections, likes, comments, user, userImageURL
        case userId = "user_id"
    }
}
