//
//  APODResponseTests.swift
//  AstroDayTests
//
//  Created by Edwy Lugo on 02/02/25.
//

import XCTest
@testable import AstroDay

class APODResponseTests: XCTestCase {

    func testDecodingAPODResponse() {
        let jsonString = """
        {
            "result": [
                {
                    "title": "Astronomy Picture of the Day",
                    "explanation": "This is the explanation of the picture.",
                    "url": "http://example.com/image.jpg",
                    "media_type": "image",
                    "date": "2025-02-02",
                    "thumbnail_url": "http://example.com/thumb.jpg",
                    "isFavorite": true
                }
            ]
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let decoder = JSONDecoder()
            let apodResponse = try decoder.decode(APODResponse.self, from: jsonData)
            
            XCTAssertEqual(apodResponse.result.count, 1)
            XCTAssertEqual(apodResponse.result[0].title, "Astronomy Picture of the Day")
            XCTAssertEqual(apodResponse.result[0].explanation, "This is the explanation of the picture.")
            XCTAssertEqual(apodResponse.result[0].url, "http://example.com/image.jpg")
            XCTAssertEqual(apodResponse.result[0].mediaType, "image")
            XCTAssertEqual(apodResponse.result[0].date, "2025-02-02")
            XCTAssertEqual(apodResponse.result[0].thumbnailUrl, "http://example.com/thumb.jpg")
            XCTAssertEqual(apodResponse.result[0].isFavorite, true)
        } catch {
            XCTFail("Failed to decode APODResponse: \(error.localizedDescription)")
        }
    }

    func testEncodingAPODResponse() {
        let apodModel = APODModel(title: "Astronomy Picture of the Day",
                                  explanation: "This is the explanation of the picture.",
                                  url: "http://example.com/image.jpg",
                                  mediaType: "image",
                                  date: "2025-02-02",
                                  thumbnailUrl: "http://example.com/thumb.jpg",
                                  isFavorite: true)
        let apodResponse = APODResponse(result: [apodModel])
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(apodResponse)
            
            let jsonString = String(data: jsonData, encoding: .utf8)
            
            XCTAssertNotNil(jsonString)
            XCTAssertTrue(jsonString!.contains("\"title\":\"Astronomy Picture of the Day\""))
            XCTAssertTrue(jsonString!.contains("\"explanation\":\"This is the explanation of the picture.\""))
            XCTAssertTrue(jsonString!.contains("\"media_type\":\"image\""))
            XCTAssertTrue(jsonString!.contains("\"isFavorite\":true"))
        } catch {
            XCTFail("Failed to encode APODResponse: \(error.localizedDescription)")
        }
    }

    func testGetThumbnailUrlForVideo() {
        let apodModel = APODModel(title: "Astronomy Picture of the Day",
                                  explanation: "This is the explanation of the picture.",
                                  url: "http://example.com/video.mp4",
                                  mediaType: "video",
                                  date: "2025-02-02",
                                  thumbnailUrl: "http://example.com/video_thumb.jpg",
                                  isFavorite: false)
        
        let thumbnailUrl = apodModel.getThumbnailUrl()
        
        XCTAssertEqual(thumbnailUrl, "http://example.com/video_thumb.jpg")
    }

    func testGetThumbnailUrlForImage() {
        let apodModel = APODModel(title: "Astronomy Picture of the Day",
                                  explanation: "This is the explanation of the picture.",
                                  url: "http://example.com/image.jpg",
                                  mediaType: "image",
                                  date: "2025-02-02",
                                  thumbnailUrl: "http://example.com/thumb.jpg",
                                  isFavorite: false)
        
        let thumbnailUrl = apodModel.getThumbnailUrl()
        
        XCTAssertEqual(thumbnailUrl, "http://example.com/image.jpg")
    }
}
