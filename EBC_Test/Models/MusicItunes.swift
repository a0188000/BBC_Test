//
//  MusicItunes.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/9.
//

import Foundation

struct Itunes: Codable {
    var totalCount: Int
    var musics: [Music]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "resultCount"
        case musics     = "results"
    }
}

struct Music: Codable {
    var artworkUrl100: String
    var longDescription: String?
}
