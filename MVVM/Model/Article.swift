//
//  Article.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation

struct Article: Codable {
    
    let newsSubsection: String
    let newsTitle: String
    let newsAbstract: String
    let newsWebUrl: String
    let newsByLine: String?
    let newsPublishedDate: String?
    let imageGallery: [ImageInformation]?
    
    enum CodingKeys: String, CodingKey {
        case newsSubsection = "subsection"
        case newsTitle = "title"
        case newsAbstract = "abstract"
        case newsWebUrl = "url"
        case newsByLine = "byline"
        case newsPublishedDate = "published_date"
        case imageGallery = "multimedia"
    }
    
}
