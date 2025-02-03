//
//  APODMovieViewControllerTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 03/02/25.
//

import XCTest
@testable import AstroDay
import WebKit

class APODMovieViewControllerTests: XCTestCase {

    var apodMovieViewController: APODMovieViewController!
    var videoURL: URL!

    override func setUp() {
        super.setUp()
        videoURL = URL(string: "https://example.com/video.mp4")
        apodMovieViewController = APODMovieViewController(videoURL: videoURL)
        apodMovieViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        apodMovieViewController = nil
        videoURL = nil
        super.tearDown()
    }

    func testViewControllerHasWKWebView() {
        XCTAssertNotNil(apodMovieViewController.webView)
    }

    func testViewControllerHasCloseButton() {
        XCTAssertNotNil(apodMovieViewController.closeButton)
    }

    func testLoadVideo() {
        apodMovieViewController.loadVideo()
        XCTAssertNotNil(apodMovieViewController.webView.url)
        XCTAssertEqual(apodMovieViewController.webView.url?.absoluteString, videoURL.absoluteString)
    }

    func testCloseButtonTapped() {
        let initialPresentingViewControllerCount = apodMovieViewController.presentingViewController?.children.count ?? 0
        apodMovieViewController.closeButton.sendActions(for: .touchUpInside)
        let finalPresentingViewControllerCount = apodMovieViewController.presentingViewController?.children.count ?? 0
        XCTAssertEqual(initialPresentingViewControllerCount - finalPresentingViewControllerCount, 0)
    }
}
