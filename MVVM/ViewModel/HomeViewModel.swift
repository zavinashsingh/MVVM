//
//  HomeViewModel.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation

protocol CompletionHandlerDelegate {
    
    func completionHandler()
    func showErrorInformation()
    func statusOfLoadingIndicator()
}

extension CompletionHandlerDelegate {
    
    func statusOfLoadingIndicator() {}
}

class HomeViewModel {
    
    //MARK: - Variables
    var delegate: CompletionHandlerDelegate?
    private let apiService: RestServiceProtocol
    private var topStories: [Article]?
    var alertMessage: String?
    var isLoading: Bool = false {
        didSet {
            delegate?.statusOfLoadingIndicator()
        }
    }
    var articleCount: Int {
        guard let articleCount = topStories?.count else { return 0 }
        return articleCount
    }
    
    func tableViewAlphaValue() -> Double {
        
        return isLoading ? 0.0 : 1.0
    }
        
    init(apiService: RestServiceProtocol = WebserviceHelper(), completionDelegate: CompletionHandlerDelegate) {
        
        self.apiService = apiService
        self.delegate = completionDelegate
    }
    
    func requestForNews() {
        
        isLoading = true
        apiService.request(baseURL: WebserviceConstant.baseURL, path: WebserviceConstant.queryPath, apiKey: WebserviceConstant.apiKey) { [weak self] (result: Result< NewsResponse, NetworkError>) in
            self?.isLoading = false
            switch result {
            case .success(let model) :
                self?.topStories = model.newsResults
                self?.delegate?.completionHandler()
            case .failure(let error) :
                self?.alertMessage = error.localizedDescription
                self?.delegate?.showErrorInformation()
            }
        }
    }
    
    func getArticleInformation( at indexPath: IndexPath ) -> Article? {
        
        guard let topStories = topStories else { return nil }
        if topStories.count > 0 && indexPath.row < topStories.count {
            return topStories[indexPath.row]
        } else { return nil }
    }
    
}
