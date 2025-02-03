//
//  APODMapper.swift
//  AstroDay
//
//  Created by Edwy Lugo on 01/02/25.
//

import Foundation

class APODMapper {
    static func map(json: Any) throws -> [APODModel] {
        if let jsonDict = json as? NSDictionary {
            if let resultArray = jsonDict["result"] as? [[String: Any]] {
                return try resultArray.map { try APODMapper.mapSingle(json: $0) }
            }
            else if let singleObject = jsonDict as? [String: Any] {
                let apod = try APODMapper.mapSingle(json: singleObject)
                return [apod]
            } else {
                throw NSError(domain: "APODMapper", code: 100, userInfo: [NSLocalizedDescriptionKey: "Estrutura JSON inesperada"])
            }
        }
        
        throw NSError(domain: "APODMapper", code: 101, userInfo: [NSLocalizedDescriptionKey: "Formato de dados inválido"])
    }
    
    static func mapSingle(json: [String: Any]) throws -> APODModel {
        let decoder = JSONDecoder()
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        let apod = try decoder.decode(APODModel.self, from: data)
        return apod
    }
}
