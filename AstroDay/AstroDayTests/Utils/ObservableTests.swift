//
//  ObservableTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class ObservableTests: XCTestCase {

    func testObservableBinding() {
        let observable = Observable(1)
        var observedValue: Int?

        observable.bind { value in
            observedValue = value
        }

        observable.value = 2

        XCTAssertEqual(observedValue, 2)
    }

    func testObservableInitialValue() {
        let observable = Observable("Initial Value")
        var observedValue: String?

        observable.bind { value in
            observedValue = value
        }

        XCTAssertEqual(observedValue, "Initial Value")
    }
}
