//
//  Observable.swift
//  AstroDay
//
//  Created by Edwy Lugo on 30/01/25.
//

final class Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ object: T) {
        value = object
    }
}
