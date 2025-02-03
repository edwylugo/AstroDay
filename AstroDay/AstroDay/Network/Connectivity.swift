//
//  Connectivity.swift
//  AstroDay
//
//  Created by Edwy Lugo on 31/01/25.
//

import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
