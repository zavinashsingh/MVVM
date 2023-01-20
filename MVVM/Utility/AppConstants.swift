//
//  AppConstants.swift
//  MVVM
//
//  Created by Avinash Singh on 20/01/2023.
//

import Foundation

struct IdentifierName {
    static let newsCell = "NewsCell"
}

struct ImageSize {
    static let mediumThreeByTwo210 = "threeByTwoSmallAt2X"
    static let largeThumbnail = "Large Thumbnail"
}

struct Strings {
    static let navigationTitleForLandingPage = "Top Stories"
    static let titleForAlertView = "Alert"
    static let newsDetails = "In Details"
    static let seeMore = "See More"
    static let back = "Back"
}

struct AccessibilityLabel {
    static let newsTableView = "newsTableView"
}

enum WebserviceConstant {
    static let queryPath = "topstories/v2/home.json"
    static let baseURL = "https://api.nytimes.com/svc/"
    static let apiKey = "NOVRG34ooMNMdAj835jgPeMIyLk1n24E"
}
