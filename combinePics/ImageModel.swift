//
//  ImageModel.swift
//  combinePics
//
//  Created by Rajveer Kaur on 18/10/22.
//

import Foundation

// MARK: - ImageModelElement
struct ImageModelElement: Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias ImageModel = [ImageModelElement]

var FavList = ImageModel()
