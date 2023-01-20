//
//  NewsTableCellViewModel.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation

protocol ImageDownloadCompletionDelegate {
    
    func completedImageDownload(newsImage: Data?)
}

class NewsTableCellViewModel {
    
    var downloadCompletionDelegate: ImageDownloadCompletionDelegate
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
                self?.downloadCompletionDelegate.completedImageDownload(newsImage: imageData)
            case .failure :
                self?.downloadCompletionDelegate.completedImageDownload(newsImage: nil)
            }
        }
    }
    func cancelRequest() {
        imageDownloderService.cancelDownloadTask()
    }
    
    func getImageUrlString(topStory: Article ) ->String? {
        
        let multimedia = topStory.imageGallery?.filter{
            $0.imageFormat == ImageSize.largeThumbnail
        }
        guard let imageUrlString =  multimedia?[0].imageUrl else { return nil }
        return imageUrlString
    }
}
