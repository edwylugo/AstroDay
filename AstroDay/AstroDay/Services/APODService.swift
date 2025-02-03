//
//  APODService.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

import Foundation

class APODService: WebService {
    
    override init() {
        super.init()
    }
    
    func fetchAPOD(
        date: String? = nil,
        startDate: String? = nil,
        endDate: String? = nil,
        count: Int? = nil,
        thumbs: Bool = false)
    {
        var queryItems: [String] = []
        var urlString = ""
        
        if let date = date {
            queryItems.append("date=\(date)")
        }
        if let startDate = startDate, let endDate = endDate {
            queryItems.append("start_date=\(startDate)")
            queryItems.append("end_date=\(endDate)")
        }
        if let count = count {
            queryItems.append("count=\(count)")
        }
        if thumbs {
            queryItems.append("thumbs=true")
        }
        
        if queryItems.count > 0 {
            urlString = "&" + queryItems.joined(separator: "&")
        }
        super.get(url: urlString)
    }
}
