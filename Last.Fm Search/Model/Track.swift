//
//  Tracks.swift
//  Last.Fm Search
//
//  Created by Owner on 06/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation


struct Track: Codable {
    var name: String
    var duration: String?
    var playcount: String?
    var listeners: String
    var mbid: String
    var url: String
    var streamable:String
    var artist: String
    var image: [Image]
    
    init(name: String ,duration: String? ,playcount: String? , listeners: String , mbid: String , url: String , streamable:String ,artist: String , image: [Image] ) {
        self.name = name
        self.duration = duration
        self.playcount = playcount
        self.listeners = listeners
        self.mbid = mbid
        self.url = url
        self.streamable = streamable
        self.artist = artist
        self.image = image
    }
    

}


