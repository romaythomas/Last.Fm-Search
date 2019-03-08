//
//  ArtistViewModel.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation





struct ArtistListViewModel {
    var artist = [ArtistViewModel]()
    var topSearches = [ArtistViewModel]()
 
    init(artist: [ArtistViewModel]) {
        self.artist = artist
        topSearches = Array (artist.prefix(3))
        
    }
}
struct ArtistChartListViewModel {
    var artist = [ArtistViewModel]()
    
    init(artist: [ArtistViewModel]) {
        self.artist = artist
    }
}

struct ArtistViewModel {
    
    var name: String
    var listeners : String?
    var playcount : String?
    var mbid: String
    var url: String
    var streamable: String?
    var imageURL : String?

    
    
    
}

extension ArtistViewModel {
    
    init(artist: Artist) {
        self.name = artist.name
        self.listeners = artist.listeners
        self.playcount = artist.playcount
        self.mbid = artist.mbid
        self.url = artist.url
        self.streamable = artist.streamable
      
        
        let imgList = artist.image
        
        for list in imgList ?? [] {
            
            if list.size == Size.large {
                
                imageURL = list.text
            }
            
        }
        
        
     
   
    }
}
