//
//  ViewModelProtocol.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    var isLoading: Observable<Bool> { get }
    var isError: Observable<String?> { get }
}
