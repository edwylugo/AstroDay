//
//  ImagesTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay

class ImagesTests: XCTestCase {

    func testVideoImage() {
        // Force access to Images.video to initialize it
        let videoImage = Images.video
        XCTAssertNotNil(videoImage, "The 'video' image should not be nil.")
        XCTAssertNotEqual(videoImage.size, CGSize(width: 1, height: 1), "The 'video' image should not be a placeholder image.")
        XCTAssertGreaterThan(videoImage.size.width, 0, "The 'video' image width should be greater than zero.")
        XCTAssertGreaterThan(videoImage.size.height, 0, "The 'video' image height should be greater than zero.")
    }

    func testSystemImages() {
        let systemImages = [
            ("heart_fill", Images.System.heart_fill),
            ("camera_fill", Images.System.camera_fill),
            ("heart", Images.System.heart),
            ("arrow_left", Images.System.arrow_left),
            ("line_decrease_circle", Images.System.line_decrease_circle),
            ("ellipsis_circle", Images.System.ellipsis_circle)
        ]
        
        systemImages.forEach { (imageName: String, image: UIImage?) in
            let unwrappedImage = image ?? UIImage()
            XCTAssertNotNil(unwrappedImage, "The \(imageName) image should not be nil.")
            XCTAssertNotEqual(unwrappedImage.size, CGSize(width: 1, height: 1), "The \(imageName) image should not be a placeholder image.")
            XCTAssertGreaterThan(unwrappedImage.size.width, 0, "The \(imageName) image width should be greater than zero.")
            XCTAssertGreaterThan(unwrappedImage.size.height, 0, "The \(imageName) image height should be greater than zero.")
        }
    }

    func testImageLoading() {
        let videoImage = Images.video
        XCTAssertTrue(videoImage.cgImage != nil, "The 'video' image should have a valid CGImage backing.")
        
        let systemHeartImage = Images.System.heart
        XCTAssertTrue(systemHeartImage.cgImage != nil, "The 'heart' image should have a valid CGImage backing.")
    }

    func testImageEquality() {
        let heartFillImage = Images.System.heart_fill
        let heartImage = Images.System.heart
        XCTAssertNotEqual(heartFillImage, heartImage, "The 'heart_fill' and 'heart' images should not be the same.")
    }
}
