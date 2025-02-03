//
//  URLBase.swift
//  AstroDay
//
//  Created by Edwy Lugo on 31/01/25.
//

import Foundation

struct URLBase {
    private static let environmentFile = Bundle.main.path(forResource: "environment", ofType: "plist")

    static func baseUrl() -> String {
        if let environmentFile = environmentFile {
            if let environmentDictionary = NSDictionary(contentsOfFile: environmentFile) {
                return environmentDictionary["apodBaseUrl"] as? String ?? ""
            }
        }
        return ""
    }
    
    static func apiKey() -> String {
        if let environmentFile = environmentFile {
            if let environmentDictionary = NSDictionary(contentsOfFile: environmentFile) {
                return environmentDictionary["apodAPIKey"] as? String ?? ""
            }
        }
        return ""
    }
}

var kWsBaseUrl = URLBase.baseUrl()
let kWsApiKey = URLBase.apiKey()
let kWsTimeOut = 120.0
