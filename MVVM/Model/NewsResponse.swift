//
//  NewsResponse.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation

struct NewsResponse : Codable {
    
    private let responseStatus : String
    private let newsCopyright : String
    let newsResults : [Article]
    
    enum CodingKeys: String, CodingKey {
        case responseStatus = "status"
        case newsCopyright = "copyright"
        case newsResults = "results"
    }
}
