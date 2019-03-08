//
//  APIChartResponse.swift
//  Last.Fm Search
//
//  Created by Owner on 06/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation


struct ArtistChart: Codable {
    let artists: Artists
}

struct Artists: Codable {
    let artist: [Artist]
    
    
    enum CodingKeys: CodingKey {
        case artist
        
    }
}


struct TracksChart: Codable {
    let tracks: Tracks
}

struct Tracks: Codable {
    let track: [Track]
    
    
    enum CodingKeys: CodingKey {
        case track
        
    }
}


