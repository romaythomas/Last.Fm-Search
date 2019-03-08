//
//  Artist.swift
//  Last.Fm Search
//
//  Created by Owner on 06/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation

struct Artist: Codable {
    var name: String
    var listeners : String?
    var playcount : String?
    var mbid: String
    var url: String
    var streamable: String?
    var image: [Image]?
    init(name: String ,playcount : String?,listeners : String? ,mbid: String,url: String ,streamable: String? ,image: [Image]?) {
        self.name = name
        self.listeners = listeners
        self.playcount = playcount
        self.mbid = mbid
        self.url = url
        self.streamable = streamable
        self.image = image
    }
}



