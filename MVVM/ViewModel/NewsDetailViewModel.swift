//
//  NewsDetailViewModel.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation

class NewsDetailsViewModel {
    
    weak var downloadCompletionDelegate: ImageDownloadCompletionDelegate?
    private let imageDownloderService: ImageDownloaderServiceProtocol

    init(imageDownloder: ImageDownloaderServiceProtocol = ImageDownloaderHelper(), downloadCompletionDelegate: ImageDownloadCompletionDelegate) {
        
        self.imageDownloderService = imageDownloder
        self.downloadCompletionDelegate = downloadCompletionDelegate
    }
    
    func downloadingImage(imageUrlString: String) {
        
        self.imageDownloderService.downloadImage(with: imageUrlString) {
            [weak self] (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let imageData):
                self?.downloadCompletionDelegate?.completedImageDownload(newsImage: imageData)
            case .failure :
                self?.downloadCompletionDelegate?.completedImageDownload(newsImage: nil)
            }
        }
    }
    
    func getImageUrlString(topStory: Article ) ->String? {
        
        let multimedia = topStory.imageGallery?.filter{
            $0.imageFormat == ImageSize.mediumThreeByTwo210
        }
        guard let multimediaElement =  multimedia?[0] else { return nil }
        let imageUrlString =  multimediaElement.imageUrl
        return imageUrlString
    }
}
