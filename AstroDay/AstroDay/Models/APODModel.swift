//
//  APODModel.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

import Foundation

struct APODResponse: Codable {
    let result: [APODModel]
}

struct APODModel: Codable {
    let title: String
    let explanation: String
    let url: String
    let mediaType: String
    let date: String
    var thumbnailUrl: String?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case title, date, explanation, url, isFavorite
        case thumbnailUrl = "thumbnail_url"
        case mediaType = "media_type"
    }
    
    func getThumbnailUrl() -> String {
        if mediaType == "video" {
            return thumbnailUrl ?? ""
        } else {
            return url
        }
    }
}
