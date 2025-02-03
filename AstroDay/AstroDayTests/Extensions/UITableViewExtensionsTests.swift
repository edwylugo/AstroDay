//
//  UITableViewExtensionsTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class UITableViewExtensionsTests: XCTestCase {
    func testReuseIdentifier() {
        class TestCell: UITableViewCell {}
        XCTAssertNotEqual(TestCell.reuseIdentifier, "TestCell", "Reuse identifier should match class name")
    }
    
    func testRegisterAndDequeueCell() {
        let tableView = UITableView()
        class TestCell: UITableViewCell {}
        
        tableView.register(cellClass: TestCell.self)
        let dequeuedCell: TestCell? = tableView.dequeue(cellClass: TestCell.self)
        XCTAssertNotNil(dequeuedCell, "Dequeued cell should not be nil")
    }
    
    func testDequeueCellWithIndexPath() {
        let tableView = UITableView()
        class TestCell: UITableViewCell {}
        
        tableView.register(cellClass: TestCell.self)
        let indexPath = IndexPath(row: 0, section: 0)
        
        let dequeuedCell: TestCell = tableView.dequeue(cellClass: TestCell.self, indexPath: indexPath)
        XCTAssertNotNil(dequeuedCell, "Dequeued cell with indexPath should not be nil")
    }
}
