//
//  ImageDownloaderHelper.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation
import UIKit

protocol ImageDownloaderServiceProtocol {
    
    func downloadImage(with imageUrlString: String?, completionHandler: @escaping (Result<Data, NetworkError>) ->Void)
    func cancelDownloadTask()
}
extension ImageDownloaderServiceProtocol {
    func cancelDownloadTask() {
        print("cancel")
    }
}

class ImageDownloaderHelper : ImageDownloaderServiceProtocol {
    
    let imageCache = NSCache<NSString, NSData>()
    var imagesDownloadStatus = [String: Bool]()
    var task: URLSessionDownloadTask!
    func downloadImage(with imageUrlString: String?, completionHandler: @escaping (Result<Data ,NetworkError>) ->Void) {
        
        guard let stringURL = imageUrlString, let url = URL(string: stringURL) else { return }
        // Checking url format
        if !verifyUrl(imageUrl: url) {
            DispatchQueue.main.async {
                completionHandler(.failure(.urlNotCorrect))
            }
        }
        let urlToString = url.absoluteString as NSString
        if let cachedImage = imageCache.object(forKey: urlToString) {
            DispatchQueue.main.async {
                completionHandler(.success(cachedImage as Data))
            }
        } else {
            //Not allowing double downloading for same urls.
            if let _ = imagesDownloadStatus[stringURL] {
                return
            }
             task =  URLSession.shared.downloadTask(with: url) { urlPath, urlResponse, error in
                guard let path = urlPath, let data = try? Data(contentsOf: path) else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.noData))
                    }
                    return
                }
                if let error = error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.transportError(error)))
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.imageCache.setObject(data as NSData, forKey: urlToString)
                    self.imagesDownloadStatus.removeValue(forKey: stringURL)
                    completionHandler(.success(data as Data))
                }
            }
            imagesDownloadStatus[stringURL] = true
            task.resume()
        }
    }
    
    private func verifyUrl(imageUrl: URL?) -> Bool {
        
        if let imageUrl = imageUrl {
            return UIApplication.shared.canOpenURL(imageUrl)
        }
        return false
    }
    func cancelDownloadTask() {
        if let task = task {
            task.cancel()
        }
    }
}

