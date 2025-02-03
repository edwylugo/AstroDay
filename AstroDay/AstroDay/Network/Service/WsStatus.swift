//
//  WsStatus.swift
//  AstroDay
//
//  Created by Edwy Lugo on 31/01/25.
//
enum WsStatus: String, CaseIterable {
    case success
    case created
    case accepted
    case noContent
    case notModified
    case notFound
    case methodNotAllowed
    case requestTimeOut
    case internalServerError
    case undefined
    case noInternet
    case conflict
    case badRequest
    case unauthorized
    case forbidden
    case tooManyRequests
    case noData

    var codeStatus: Int {
        switch self {
        case .success: return 200
        case .created: return 201
        case .accepted: return 202
        case .noContent: return 204
        case .notModified: return 304
        case .badRequest: return 400
        case .unauthorized: return 401
        case .forbidden: return 403
        case .notFound: return 404
        case .methodNotAllowed: return 405
        case .requestTimeOut: return 408
        case .internalServerError: return 500
        case .noInternet: return -1
        case .conflict: return 409
        case .undefined: return 99
        case .tooManyRequests: return 429
        case .noData: return 550
        }
    }
}
