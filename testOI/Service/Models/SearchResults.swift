//
//  SearchResults.swift
//  testOI
//
//  Created by Alex Ch. on 08.01.2022.
//

import Foundation

struct SearchResults: Decodable {
    let imageResults: [GoogleImageResult]
    enum CodingKeys: String, CodingKey {
        case imageResults = "images_results"
    }
}

struct GoogleImageResult: Decodable {
    let original: String?
    let thumbnail: String?
    let width = 20
    let height = 20
}
