//
//  Configurable.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

protocol Configurable: AnyObject {
    associatedtype Configuration

    func configure(content: Configuration)
}
