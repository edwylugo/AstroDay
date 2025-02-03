//
//  Apply.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

import Foundation

protocol Apply {}

extension Apply where Self: Any {
    @discardableResult
    func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Apply {}
extension JSONDecoder: Apply {}
extension JSONEncoder: Apply {}
