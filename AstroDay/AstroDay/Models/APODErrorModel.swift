//
//  APODErrorModel.swift
//  AstroDay
//
//  Created by Edwy Lugo on 31/01/25.
//

import Foundation

struct APIErrorResponse: Codable {
    let error: APIError
}

struct APIError: Codable {
    let message: String
    let code: String
}
