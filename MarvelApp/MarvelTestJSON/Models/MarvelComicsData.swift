//
//  MarvelComicsData.swift
//  MarvelTestJSON
//
//  Created by Andrii Stetsenko on 07.09.2022.
//

import Foundation

// MARK: - MarvelComicsData
struct MarvelComicsData: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    var data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let limit, total, count: Int
    var results: [Result] = []
    var offset: Int
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: Date
    let thumbnail: Thumbnail
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

