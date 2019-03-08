//
//  APIResponseModel.swift
//  Last.Fm Search
//
//  Created by Owner on 06/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation

struct APISearchResponse: Codable {
    let results: Results
}

struct Results: Codable {
    let albummatches: AlbumMatches?
    let artistmatches: ArtistMatches?
    let trackmatches: TrackMatches?
    
    
    enum CodingKeys: CodingKey {
        case artistmatches
        case albummatches
        case trackmatches
    }
}


struct ArtistMatches: Codable {
    let artist: [Artist]
}
struct AlbumMatches: Codable {
    let album: [Album]
}
struct TrackMatches: Codable {
    let track: [Track]
}









