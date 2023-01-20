//
//  NewsDetailsViewModelTest.swift
//  MVVMTests
//
//  Created by Avinash Singh on 20/01/2023.
//

import XCTest
@testable import MVVM

class NewsDetailsViewModelTest: XCTestCase, ImageDownloadCompletionDelegate {
    
    var newsDetailsViewModelTest: NewsDetailsViewModel!
    private var downloadExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func testImageDownLoading() {
        
        let spyDeleagte =  SpyDeleagte(validImagePath: "placeholder")
        newsDetailsViewModelTest = NewsDetailsViewModel(imageDownloder: spyDeleagte, downloadCompletionDelegate: self)
        spyDeleagte.asyncExpetation = downloadExpectation
        newsDetailsViewModelTest.downloadingImage(imageUrlString: "https://test.jpg")
    }
    
    func completedImageDownload(newsImage: Data?) {
        
        if newsImage != nil {
            XCTAssertNotNil(newsImage)
        }
    }
    
    override func tearDownWithError() throws {
        
        newsDetailsViewModelTest = nil
    }
    
}
