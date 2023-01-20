//
//  ImageInformation.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation

struct ImageInformation: Codable {
    
    let imageUrl: String
    let imageFormat: String
    private let imageHeight: Int
    private let imageWidth: Int
    private let imageType: String
    private let imageCopyright: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
        case imageFormat = "format"
        case imageHeight = "height"
        case imageWidth = "width"
        case imageType = "type"
        case imageCopyright = "copyright"
    }
}
