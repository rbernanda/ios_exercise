//
//  UserResponse.swift
//  PromoApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import Foundation

struct Promos: Codable {
    let promos: [SinglePromo]
}

struct SinglePromo: Codable, Hashable {
    let id: Int
    let name: String
    let imagesUrl: String
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imagesUrl = "images_url"
        case detail
    }
}
