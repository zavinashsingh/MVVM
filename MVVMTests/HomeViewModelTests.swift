//
//  HomeViewModelTests.swift
//  MVVMTests
//
//  Created by Avinash Singh on 20/01/2023.
//



import XCTest
@testable import MVVM

class HomeViewModelTests: XCTestCase, CompletionHandlerDelegate{
    
    var homeViewModel: HomeViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        
        super.setUp()
    }
    
    override func tearDown() {
        
        homeViewModel = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testSuccessfullyTopStoriesFetching() {
        
        guard let mockResponseData = StubGenerator().stubTopStories(fileName: "TestData", fileType: "json") else { return }
        let mockAPIService = MockApiService(responseStatus: true, topStories: mockResponseData, error: nil)
        homeViewModel = HomeViewModel(apiService: mockAPIService, completionDelegate: self)
        homeViewModel?.requestForNews()
    }
    func completionHandler() {
        //Assert
        XCTAssertEqual(homeViewModel.articleCount, 7, "Expected 7 articles")
        
        let article = homeViewModel?.getArticleInformation(at: IndexPath(row: 1, section: 0))
        //Assert
        XCTAssertEqual( article?.newsTitle, "A Detailed Picture of What’s in the Democrats’ Climate and Health Bill")
        XCTAssertEqual( article?.newsByLine, "By Francesca Paris, Alicia Parlapiano, Margot Sanger-Katz and Eve Washington")
        
        let selectedArticle = homeViewModel?.getArticleInformation(at:IndexPath(row: 3, section: 0))
        //Assert
        XCTAssertEqual( selectedArticle?.newsTitle, "U.S. Says Al Qaeda Has Not Regrouped in Afghanistan")
        XCTAssertEqual( selectedArticle?.newsByLine, "By Eric Schmitt")
    }
    
    func showErrorInformation() {
        
        //Assert
        XCTAssertEqual(homeViewModel.articleCount, 0, "Expected no data")
        
        let article = homeViewModel?.getArticleInformation(at: IndexPath(row: 1, section: 0))
        //Assert
        XCTAssertNil( article?.newsTitle, "NewsTitle will be nil")
        XCTAssertNil( article?.newsByLine, "NewsByLine weill be nil")
        let selectedArticle = homeViewModel?.getArticleInformation(at:IndexPath(row: 3, section: 0))
        //Assert
        XCTAssertNil( selectedArticle?.newsTitle, "NewsTitle will be nil")
        XCTAssertNil( selectedArticle?.newsByLine, "NewsByLine will be nil")
        XCTAssertNotNil(homeViewModel?.alertMessage)
    }
    
    func testFetchingfailureTopStories() {
        
        let mockAPIService = MockApiService(responseStatus: false, topStories: nil, error: NetworkError.noData)
        homeViewModel = HomeViewModel(apiService: mockAPIService, completionDelegate: self)
        homeViewModel.delegate = self
        homeViewModel?.requestForNews()
    }
}

class MockApiService: RestServiceProtocol {
    
    var isFetchTopStoriesCalled = false
    var completeTopStories: Data?
    var responseStatus = false
    var error: NetworkError?
    
    init(responseStatus: Bool, topStories: Data?, error: NetworkError?) {
        
        self.responseStatus = responseStatus
        self.completeTopStories = topStories
        self.error = error
    }
    
    func request<T : Decodable>(baseURL: String, path: String, apiKey: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        isFetchTopStoriesCalled = true
        if responseStatus {
            guard let data = completeTopStories else {
                completion(.failure(.noData))
                return
            }
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        } else {
            completion(.failure(.noData))
        }
        
    }
    
}

class StubGenerator {
    
    fileprivate func stubTopStories(fileName: String, fileType: String) -> Data? {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else { return nil }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            return nil
        }
    }
    
}

