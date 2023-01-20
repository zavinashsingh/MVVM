//
//  NewsTableCellViewModelTest.swift
//  MVVMTests
//
//  Created by Avinash Singh on 20/01/2023.
//



import XCTest
@testable import MVVM

class NewsTableCellViewModelTest: XCTestCase, ImageDownloadCompletionDelegate {
    
    var newsTableCellViewModel: NewsTableCellViewModel!
    private var downloadExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testImageDownLoading() {
        
        let spyDeleagte =  SpyDeleagte(validImagePath: "placeholder")
        newsTableCellViewModel = NewsTableCellViewModel(imageDownloder: spyDeleagte, downloadCompletionDelegate: self)
        spyDeleagte.asyncExpetation = downloadExpectation
        newsTableCellViewModel.downloadingImage(imageUrlString: "https://test.jpg")
    }
    
    func completedImageDownload(newsImage: Data?) {
        
        if newsImage != nil {
            XCTAssertNotNil(newsImage)
        }
    }
    
    override func tearDownWithError() throws {
        
        newsTableCellViewModel = nil
    }
    
}

class SpyDeleagte: ImageDownloaderServiceProtocol {
    
    var somethingWithDelegateAsyncResult: Data?
    var asyncExpetation: XCTestExpectation?
    private var validImagePath: String
    
    init(validImagePath: String) {
        
        self.validImagePath = validImagePath
    }
    
    func downloadImage (with imageUrlString: String?, completionHandler: @escaping (Result<Data ,NetworkError>) ->Void) {
        
        let image = UIImage(named: validImagePath)
        guard let imageData = image?.pngData() else {
            return completionHandler(.failure(.noData))
        }
        somethingWithDelegateAsyncResult = imageData
        completionHandler(.success(imageData))
    }
    
}

