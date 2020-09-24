//
//  Image.swift
//  HanYuko_v2
//
//  Created by Jacob Pernell on 9/14/20.
//  Copyright © 2020 Jacob Pernell. All rights reserved.
//

import Foundation

struct ImagesResponse: Decodable {
    var results: [UnsplashImage]
}

struct UnsplashImage: Decodable {
    var id: String
    var description: String?
    var altDescription: String?
//    let user: User
//    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case altDescription = "alt_description"
//        case user
//        case links
    }
}
/*
struct User: Decodable { // Author of the photo
    let username: String
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case username
        case name
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Decodable {
    let mediumImage: String
    
    enum CodingKeys: String, CodingKey {
        case mediumImage = "medium"
    }
}

struct Links: Decodable {
    let originalURL: URL // URL for original unsplash page
    
    enum CodingKeys: String, CodingKey {
        case originalURL = "html"
    }
}
*/

