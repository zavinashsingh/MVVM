//
//  WenserviceHelper.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation

enum NetworkError: Error {
    
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case urlNotCorrect
    case decodingError(Error)
    case encodingError(Error)
}

protocol RestServiceProtocol {
    
    func request <T: Decodable>(baseURL: String, path: String, apiKey: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class UrlComponents {
    
    let path: String
    let baseURL: String
    let apiKey: String
    var url: URL {
        var query = [String]()
        query.append("api-key=\(apiKey)")
        guard let composedUrl = URL(string: "?" + query.joined(separator: "&"), relativeTo: NSURL(string: baseURL + path + "?") as URL?) else {
            fatalError("Unable to build request url")
        }
        return composedUrl
    }
    
    init(baseURL: String, path: String, apiKey: String) {
        
        self.path = path
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}

struct WebserviceHelper: RestServiceProtocol {
    
    func request <T: Decodable>(baseURL: String, path: String, apiKey: String, completion: @escaping (Result<T,NetworkError>) -> Void) {
       
        let urlComponents = UrlComponents(baseURL: baseURL, path: path, apiKey: apiKey)
        let urlRequest = URLRequest(url: urlComponents.url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //Handle error case
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                 let responseData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
    
}

